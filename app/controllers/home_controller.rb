class HomeController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result
    .includes(:category)
    .where(deleted_at: nil)
    .page(params[:page])
    .per(8)
@categories = Category.all # Para la lista desplegable
  end
end
