class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    params[:product][:images] = params[:product][:new_images] if params[:product][:new_images].present?
  
    @product = Product.new(product_params.except(:new_images))
  
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      product_update_params = product_params.except(:new_images)
      if @product.update(product_update_params)
        save_images if params[:product][:new_images].present?
        format.html { redirect_to @product, notice: "The product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def save_images
  params[:product][:new_images].each do |image|
    next if image.blank?
    @product.images.attach(image)
  end
end

    # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
    
  def product_params
    params.require(:product).permit(:name, :description, :inventory_entry_date, :available_stock, :unit_price, :size_id, :color_id, :category_id, images: [], new_images: [])
  end
  
end
