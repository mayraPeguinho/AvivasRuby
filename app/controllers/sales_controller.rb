class SalesController < ApplicationController
  before_action :set_sale, only: %i[show edit update destroy]
  before_action :ensure_active_sale, only: %i[edit update destroy]

  # GET /sales or /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1 or /sales/1.json
  def show
    # Permitir mostrar incluso si la venta está eliminada
  end
  
  # GET /sales/1/edit
  def edit
    # Restricción implementada en ensure_active_sale
  end

  def new
    @sale = Sale.new
    product_sold = @sale.product_solds.build
    product_sold.sale_price = product_sold.product.unit_price if product_sold.product
  end
  
  def create
    @sale = Sale.new(sale_params)

    @sale.product_solds.each do |product_sold|
      product_sold.sale_price ||= product_sold.product.unit_price
    end

    if valid_stock?
      respond_to do |format|
        ActiveRecord::Base.transaction do
          @sale.total_sale = @sale.product_solds.sum { |product_sold| product_sold.amount * product_sold.sale_price }

          if @sale.save
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
      @sale.errors.add(:base, "Not enough stock available for one or more products.")
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /sales/1 or /sales/1.json
  def update
    # Restricción implementada en ensure_active_sale
  end

  # DELETE /sales/1 or /sales/1.json
  def destroy
    respond_to do |format|
      ActiveRecord::Base.transaction do
        @sale.update!(deleted_at: Time.current)
        
        @sale.product_solds.each do |product_sold|
          product = product_sold.product
          if product.deleted_at.nil? 
            product.update!(available_stock: product.available_stock + product_sold.amount)
          end
        end
        
        format.html { redirect_to sales_path, status: :see_other, notice: "Sale was successfully marked as deleted." }
        format.json { head :no_content }
      end
    rescue StandardError => e
      format.html { redirect_to sales_path, alert: "Error deleting sale: #{e.message}" }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Método para restringir acceso si la venta está eliminada
    def ensure_active_sale
      if @sale.deleted_at.present?
        respond_to do |format|
          format.html { redirect_to sales_path, alert: "This sale has been deleted and cannot be modified." }
          format.json { render json: { error: "This sale has been deleted and cannot be modified." }, status: :forbidden }
        end
      end
    end

    def valid_stock?
      @sale.product_solds.all? do |product_sold|
        product_sold.product.available_stock >= product_sold.amount
      end
    end

    def sale_params
      params.require(:sale).permit(
        :user_id, 
        :client, 
        :realization_datetime, 
        product_solds_attributes: [:product_id, :amount, :_destroy]
      )
    end
end
