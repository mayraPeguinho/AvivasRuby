require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "should create product" do
    visit products_url
    click_on "New product"

    fill_in "Available stock", with: @product.available_stock
    fill_in "Category", with: @product.category_id
    fill_in "Color", with: @product.color_id
    fill_in "Delete date", with: @product.delete_date
    fill_in "Description", with: @product.description
    fill_in "Inventory entry date", with: @product.inventory_entry_date
    check "Is deleted" if @product.is_deleted
    fill_in "Name", with: @product.name
    fill_in "Size", with: @product.size_id
    fill_in "Unit price", with: @product.unit_price
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "should update Product" do
    visit product_url(@product)
    click_on "Edit this product", match: :first

    fill_in "Available stock", with: @product.available_stock
    fill_in "Category", with: @product.category_id
    fill_in "Color", with: @product.color_id
    fill_in "Delete date", with: @product.delete_date
    fill_in "Description", with: @product.description
    fill_in "Inventory entry date", with: @product.inventory_entry_date
    check "Is deleted" if @product.is_deleted
    fill_in "Name", with: @product.name
    fill_in "Size", with: @product.size_id
    fill_in "Unit price", with: @product.unit_price
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "should destroy Product" do
    visit product_url(@product)
    click_on "Destroy this product", match: :first

    assert_text "Product was successfully destroyed"
  end
end
