class ProductVariantsController < ApplicationController
    before_action :authenticate_user!

    def index
      @sizes = Size.all
      @colors = Color.all
      @categories = Category.all
    end
  end
  