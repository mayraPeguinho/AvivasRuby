class SalesController < ApplicationController
  before_action :set_sale, only: %i[show edit update destroy]

  # GET /sales or /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1 or /sales/1.json
  def show
  end
  
  # GET /sales/1/edit
  def edit
  end

  def new
    @sale = Sale.new
    # Crear un producto por defecto
    product_sold = @sale.product_solds.build
    # Asignar el sale_price al valor del unit_price del producto
    product_sold.sale_price = product_sold.product.unit_price if product_sold.product
  end
  
  def create
    @sale = Sale.new(sale_params)

    # Asignar sale_price a cada producto vendido antes de guardar
    @sale.product_solds.each do |product_sold|
      product_sold.sale_price ||= product_sold.product.unit_price
    end

    # Validar si hay suficiente stock antes de calcular el total
    if valid_stock?
      respond_to do |format|
        # Guardamos la venta dentro de una transacción para asegurar la integridad de la base de datos
        ActiveRecord::Base.transaction do
          # Calcular el total de la venta después de verificar el stock
          @sale.total_sale = @sale.product_solds.sum { |product_sold| product_sold.amount * product_sold.sale_price }

          # Guardamos la venta primero (sin restar stock todavía)
          if @sale.save
            # Después de guardar, restamos el stock
            @sale.product_solds.each do |product_sold|
              product = product_sold.product
              product.update!(available_stock: product.available_stock - product_sold.amount)
            end
            format.html { redirect_to @sale, notice: "Sale was successfully created." }
            format.json { render :show, status: :created, location: @sale }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @sale.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      # Si no hay suficiente stock, mostrar error y renderizar el formulario nuevamente
      @sale.errors.add(:base, "Not enough stock available for one or more products.")
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /sales/1 or /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: "Sale was successfully updated." }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1 or /sales/1.json
  def destroy
    @sale.destroy!

    respond_to do |format|
      format.html { redirect_to sales_path, status: :see_other, notice: "Sale was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Método para verificar si el stock disponible es suficiente para cada producto vendido
    def valid_stock?
      @sale.product_solds.all? do |product_sold|
        product_sold.product.available_stock >= product_sold.amount
      end
    end

    # Solo permitir parámetros de confianza.
    def sale_params
      params.require(:sale).permit(
        :user_id, 
        :client, 
        :realization_datetime, 
        product_solds_attributes: [:product_id, :amount, :_destroy] # No incluimos :sale_price
      )
    end
end
