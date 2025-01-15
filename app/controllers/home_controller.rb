class HomeController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:category).where(deleted_at: nil)
    @categories = Category.all # Para la lista desplegable
  end
end