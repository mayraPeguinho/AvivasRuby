class SizesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_size, only: %i[show edit update destroy]
  before_action :check_associations, only: %i[edit update destroy]

  # GET /sizes or /sizes.json
  def index
    @sizes = Size.all
  end

  # GET /sizes/1 or /sizes/1.json
  def show
  end

  # GET /sizes/new
  def new
    @size = Size.new
  end

  # GET /sizes/1/edit
  def edit
  end

  # POST /sizes or /sizes.json
  def create
    @size = Size.new(size_params)

    respond_to do |format|
      if @size.save
        format.html { redirect_to product_variants_path, notice: "Size was successfully created." }
        format.json { render :show, status: :created, location: @size }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sizes/1 or /sizes/1.json
  def update
    respond_to do |format|
      if @size.update(size_params)
        format.html { redirect_to product_variants_path, notice: "Size was successfully updated." }
        format.json { render :show, status: :ok, location: @size }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sizes/1 or /sizes/1.json
  def destroy
    @size.destroy!
    respond_to do |format|
      format.html { redirect_to product_variants_path, status: :see_other, notice: "Size was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_size
    @size = Size.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def size_params
    params.require(:size).permit(:name)
  end

  def check_associations
    if @size.products.exists?
      respond_to do |format|
        format.html { redirect_to product_variants_path, alert: "Cannot edit or delete size with associated products." }
        format.json { render json: { error: "Cannot edit or delete size with associated products." }, status: :unprocessable_entity }
      end
    end
  end
  
end
