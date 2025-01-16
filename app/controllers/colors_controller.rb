class ColorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_color, only: %i[show edit update destroy]
  before_action :check_associations, only: %i[edit update destroy]

  # GET /colors or /colors.json
  def index
    @colors = Color.all
  end

  # GET /colors/1 or /colors/1.json
  def show
  end

  # GET /colors/new
  def new
    @color = Color.new
  end

  # GET /colors/1/edit
  def edit
  end

  # POST /colors or /colors.json
  def create
    @color = Color.new(color_params)

    respond_to do |format|
      if @color.save
        format.html { redirect_to product_variants_path, notice: "Color was successfully created." }
        format.json { render :show, status: :created, location: @color }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colors/1 or /colors/1.json
  def update
    respond_to do |format|
      if @color.update(color_params)
        format.html { redirect_to product_variants_path, notice: "Color was successfully updated." }
        format.json { render :show, status: :ok, location: @color }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colors/1 or /colors/1.json
  def destroy
    @color.destroy!

    respond_to do |format|
      format.html { redirect_to product_variants_path, status: :see_other, notice: "Color was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_color
    @color = Color.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def color_params
    params.require(:color).permit(:name)
  end

  # Prevent editing or deleting if there are associated products
  def check_associations
    if @color.products.exists?
      respond_to do |format|
        format.html { redirect_to product_variants_path, notice: "Cannot edit or delete color with associated products." }
        format.json { render json: { error: "Cannot edit or delete color with associated products." }, status: :unprocessable_entity }
      end
    end
  end
end
