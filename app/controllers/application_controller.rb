class ApplicationController < ActionController::Base
protected

  def set_search
    return unless request.get?
    @suggestions = Product.all_stock.map do |p|
      {
        label: "#{p.title} (#{p.vendor})",
        url: product_search_path(p.handle)
      }
    end
  end
end
