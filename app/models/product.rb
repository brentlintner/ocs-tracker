require "net/http"
require "json"
require "strain"
require "json_wrapper"

class Product < ApplicationRecord
  OCS_HOST = "https://ocs.ca"
  OCS_PRODUCTS_LIST = "/collections/dried-flower-cannabis/products.json"
  OCS_GET_ARGS = "?limit=1000"
  PRODUCTS_URL = "#{OCS_HOST}#{OCS_PRODUCTS_LIST}#{OCS_GET_ARGS}"

  def available_only_1g
    available && p_v_1g && !p_v_default && !p_v_3_5g && !p_v_7g && !p_v_15g
  end

  def self.sync
    update_products
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
      "AND p_v_15g IS NOT TRUE")
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

  def self.update_products
    products = get_products

    existing_product_ids = []
    recently_stocked_product_ids = []

    products.each do |shopify_product|
      product = Product.find_or_initialize_by p_id: shopify_product.id

      previous_available = product.available
      previous_available_only_1g = product.available_only_1g

      product.p_id         = shopify_product.id.to_s
      product.title        = shopify_product.title
      product.handle       = shopify_product.handle
      product.vendor       = shopify_product.vendor
      product.p_created_at = shopify_product.created_at.to_datetime
      product.strain       = Strain.name product

      # TODO: less manual / shitty (use sub model?)
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
        when "Default Title"
          # TODO: weird for ones with only one size
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
        product.p_v_7g || product.p_v_15g)

      existing_product_ids << product.id

      if previous_available != true && product.available
        recently_stocked_product_ids << product.id
        product.last_unavailable = DateTime.now - 10.minutes
      end

      if previous_available == true && product.available != true
        product.last_available = DateTime.now - 10.minutes
      end

      # -----------

      product.save!
    end

    all_product_ids = Product.pluck :id
    non_existing_product_ids = all_product_ids - existing_product_ids
    # TODO: probably better to get available: true vs clobber all
    non_existing_product_ids.each do |id|
      # clobber all to unstocked
      product = Product.find id

      # only count unstocked as ones that were previously available
      if product.available
        product.last_available = DateTime.now - 10.minutes
      end

      product.available = false
      product.p_v_default = product.p_v_default == true ? false : product.p_v_default
      product.p_v_1g =      product.p_v_1g      == true ? false : product.p_v_1g
      product.p_v_3_5g =    product.p_v_3_5g    == true ? false : product.p_v_3_5g
      product.p_v_7g =      product.p_v_7g      == true ? false : product.p_v_7g
      product.p_v_15g =     product.p_v_15g     == true ? false : product.p_v_15g

      # -----------

      product.save!
    end

    # -----------

    send_restocked_notifications recently_stocked_product_ids
  end

private

  def self.send_restocked_notifications product_ids
    return unless product_ids.length > 0
    EmailAlertUser.confirmed.find_each do |user|
      user.send_recently_stocked_email product_ids
    end
  end

  def self.get_products
    uri = URI PRODUCTS_URL
    response = Net::HTTP.get uri
    json = JSON.parse response
    # TODO: avoid values key overriding
    json["products"].map do |product|
      JSONWrapper.new product
    end
  end
end
