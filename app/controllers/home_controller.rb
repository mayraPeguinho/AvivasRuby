class HomeController < ApplicationController
  def index
    @products = Product.where(deleted_at: nil)
  end
end
