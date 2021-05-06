require "net/http"
require "json"
require "strain"
require "json_wrapper"

class Product < ApplicationRecord
  OCS_HOST = "https://ocs.ca"
  OCS_PRODUCTS_LIST = "/collections/dried-flower/products.json"
  PRODUCTS_URL = "#{OCS_HOST}#{OCS_PRODUCTS_LIST}"
  PAGE_LIMIT = 50
  MAX_ATTEMPTS = 50
  QUERY_DELAY = 0.05

  def available_only_1g
    available && p_v_1g && !p_v_default && !p_v_3_5g && !p_v_7g && !p_v_15g && !p_v_28g
  end

  def self.sync
    update_products
  end

  def self.sync_no_notify
    update_products notify: false
  end

  def self.all_stock
    order :vendor
  end

  def self.in_stock
    all_stock.where available: true
  end

  def self.out_of_stock
    all_stock.where available: false
  end

  def self.low_stock
    all_stock.where(
      "available = true AND p_v_1g = true AND "\
      "p_v_3_5g IS NOT TRUE AND p_v_7g IS NOT TRUE "\
      "AND p_v_15g IS NOT TRUE AND p_v_28g IS NOT TRUE")
  end

  def self.recently_stocked
    all_stock.where(
      "available = true AND last_unavailable > ?",
      (DateTime.now - 2.5))
  end

  def self.recently_sold_out
    all_stock.where(
      "available = false AND last_available > ?",
      (DateTime.now - 2.5))
  end

  def self.new_products
    all_stock.where("p_created_at > ?", (DateTime.now - 30))
  end

  def self.sativa
    all_stock.where(plant: "Sativa")
  end

  def self.indica
    all_stock.where(plant: "Indica")
  end

  def self.hybrid
    all_stock.where(plant: "Hybrid")
  end

protected

  def self.update_products notify: true
    existing_product_ids = []

    products = get_products

    recently_stocked_product_ids = []

    products.each do |shopify_product|
      product = Product.find_or_initialize_by(
        vendor: shopify_product.vendor,
        title: shopify_product.title
      )

      previous_available = product.available
      previous_available_only_1g = product.available_only_1g

      product.p_id         = shopify_product.id.to_s
      product.title        = shopify_product.title
      product.handle       = shopify_product.handle
      product.vendor       = shopify_product.vendor
      product.p_created_at = shopify_product.created_at.to_datetime
      product.strain       = Strain.name shopify_product

      variants = shopify_product.fetch("variants", [])
      variants.each do |variant|
        avail = variant["available"]
        case variant["title"]
        when "1g"
          product.p_v_1g   = avail
        when "3.5g"
          product.p_v_3_5g = avail
        when "7g"
          product.p_v_7g   = avail
        when "15g"
          product.p_v_15g  = avail
        when "28g"
          product.p_v_28g  = avail
        when "Default Title"
          product.p_v_default = true
          break
        end
      end

      tags = shopify_product.fetch("tags", [])
      plant_type_idx = tags.index { |tag| tag.start_with? "plant_type" }
      product.plant = (plant_type_idx ?
                       tags[plant_type_idx].gsub("plant_type--", "") : "Unknown"
                      ).gsub("Dominant", "").strip

      product.available = !!(product.p_v_default ||
        product.p_v_1g || product.p_v_3_5g ||
        product.p_v_7g || product.p_v_15g ||
        product.p_v_28g)

      if previous_available != true && product.available
        recently_stocked_product_ids << product.id
        product.last_unavailable = DateTime.now - 10.minutes
      end

      if previous_available == true && product.available != true
        product.last_available = DateTime.now - 10.minutes
      end

      product.save!

      existing_product_ids << product.id
    end

    all_product_ids = Product.pluck :id

    non_existing_product_ids = all_product_ids - existing_product_ids.uniq

    non_existing_product_ids.each do |id|
      product = Product.find id

      if product.available
        product.last_available = DateTime.now - 10.minutes
      end

      product.available = false
      product.p_v_default = product.p_v_default == true ? false : product.p_v_default
      product.p_v_1g =      product.p_v_1g      == true ? false : product.p_v_1g
      product.p_v_3_5g =    product.p_v_3_5g    == true ? false : product.p_v_3_5g
      product.p_v_7g =      product.p_v_7g      == true ? false : product.p_v_7g
      product.p_v_15g =     product.p_v_15g     == true ? false : product.p_v_15g
      product.p_v_28g =     product.p_v_28g     == true ? false : product.p_v_28g

      product.save!
    end

    if notify
      send_restocked_notifications recently_stocked_product_ids
    end
  end

private

  def self.send_restocked_notifications product_ids
    return unless product_ids.length > 0
    EmailAlertUser.confirmed.find_each do |user|
      user.send_recently_stocked_email product_ids
    end
  end

  def self.get_products
    total_products = []
    page = 1
    attempts = 1

    loop do
      query_args = "?limit=#{PAGE_LIMIT}&page=#{page}"
      uri = URI "#{PRODUCTS_URL}#{query_args}"

      begin
        response = Net::HTTP.get uri
        json = JSON.parse response
        products = json["products"].map do |product|
          JSONWrapper.new product
        end
        sleep QUERY_DELAY
      rescue
        attempts += 1
        next
      end

      total_products << products

      if attempts >= MAX_ATTEMPTS
        raise Exception.new "ABORT: #{attempts} attempts made querying #{uri}"
      end

      break if products.length == 0 || products.length < PAGE_LIMIT

      attempts += 1
      page += 1
    end

    total_products.flatten!
  end
end
