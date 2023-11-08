require 'rails_helper'

RSpec.describe Product, type: :model do

    it "is valid with all four fields(name, price, quantity, category) set" do
      category = Category.create(name: "Test Category")
      product = Product.new(
        name: "Test Product",
        price: 19.99,
        quantity: 100,
        category: category
    )
    expect(product.valid?).to be(true), "Errors: #{product.errors.full_messages.join(', ')}"
end

    it "is not valid without a name" do
      category = Category.create(name: "Test Category")
      product = Product.new(
        price: 19.99,
        quantity: 100,
        category: category
      )
      expect(product.valid?).to be(false), "Errors: #{product.errors.full_messages.join(', ')}"
    end

    it "is not valid without a price" do
      category = Category.create(name: "Test Category")
      product = Product.new(
      name: "Test Product",
      quantity: 100,
      category: category
      )
      expect(product.valid?).to be(false), "Errors: #{product.errors.full_messages.join(', ')}"
    end
    
    it "is not valid without a quantity" do
      category = Category.create(name: "Test Category")
      product = Product.new(
        name: "Test Product",
        price: 19.99,
        category: category
      )
      expect(product.valid?).to be(false), "Errors: #{product.errors.full_messages.join(', ')}"
    end
    
    it "is not valid without a category" do
      product = Product.new(
        name: "Test Product",
        price: 199.99,
        quantity: 100
      )
      expect(product.valid?).to be(false), "Errors: #{product.errors.full_messages.join(', ')}"
    end

end
