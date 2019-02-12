class ProductsController < ApplicationController
  before_action :set_search

  def in_stock
    @products = Product.in_stock
    @title = "In Stock"
    render "products/product_list"
  end

  def out_of_stock
    @products = Product.out_of_stock
    @title = "Out Of Stock"
    render "products/product_list"
  end

  def low_stock
    @products = Product.low_stock
    @title = "Low In Stock"
    render "products/product_list"
  end

  def all_stock
    @products = Product.all_stock
    @title = "All Stock"
    render "products/product_list"
  end

  def new_products
    @products = Product.new_products
    @title = "New Products"
    render "products/product_list"
  end

  def recently_stocked
    @products = Product.recently_stocked
    @title = "Recently Stocked"
    render "products/product_list"
  end

  def recently_sold_out
    @products = Product.recently_sold_out
    @title = "Recently Sold Out"
    render "products/product_list"
  end

  def product_search
    @products = [ Product.find_by(handle: params.permit(:handle)[:handle]) ]
    product = @products.first
    @title = "#{product.title} - #{product.vendor}"
    render "products/product_list"
  end

  def sativa
    @products = Product.sativa
    @title = "Sativa"
    render "products/product_list"
  end

  def indica
    @products = Product.indica
    @title = "Indica"
    render "products/product_list"
  end

  def hybrid
    @products = Product.hybrid
    @title = "Hybrid"
    render "products/product_list"
  end
end
