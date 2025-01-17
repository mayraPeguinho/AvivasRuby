class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy update_stock]
  before_action :check_if_deleted, only: %i[edit update edit_stock update_stock destroy]

  # GET /products or /products.json
  def index
    @products = Product.order(:deleted_at, :name)
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
    @product = Product.find(params[:id])

    if @product.update(deleted_at: Time.current, available_stock: 0)
      respond_to do |format|
        format.html { redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to products_path, status: :unprocessable_entity, alert: "Error updating the product." }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

 # GET /products/:id/edit_stock
def edit_stock
  @product = Product.find(params[:id])
end

# PATCH /products/:id/update_stock
def update_stock
  @product = Product.find(params[:id])
  if @product.update(stock_params)
    redirect_to products_path, notice: "Stock updated successfully."
  else
    render :edit_stock, alert: "There was an error updating the stock."
  end
end

  private

  # Método para adjuntar imágenes
  def save_images
    params[:product][:new_images].each do |image|
      next if image.blank?
      @product.images.attach(image)
    end
  end

  # Establece el producto que se está manipulando
  def set_product
    @product = Product.find(params[:id]) # Corregido
  end

  # Parámetros permitidos para actualizar productos
  def product_params
    params.require(:product).permit(:name, :description, :inventory_entry_date, :available_stock, :unit_price, :size_id, :color_id, :category_id, images: [], new_images: [])
  end

  # Parámetros permitidos para actualizar solo el stock
  def stock_params
    params.require(:product).permit(:available_stock)
  end

  def check_if_deleted
    if @product && @product.deleted_at.present?
      redirect_to @product, alert: "Este producto ha sido eliminado y no puede ser modificado."
    end
    # Si @product es nil o no tiene una fecha en deleted_at, la ejecución continúa normalmente.
  end
  
  
end

