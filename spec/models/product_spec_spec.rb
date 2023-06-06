require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'is valid with all the values' do
      @category = Category.create! name: 'flower'
      @product = @category.products.create!({
        name:  'Tulip',
        quantity: 10,
        price_cents: 49.99
      })
      expect(@product).to be_valid
    end
    it 'is not valid without name' do
      @category = Category.new 
      @category.name = 'flower'
      @product = @category.products.new
      @product.name = nil
      @product.quantity = 10
      @product.price_cents = 49.99
      @product.validate
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'is not valid without quantity' do
      @category = Category.new 
      @category.name = 'flower'
      @product = @category.products.new
      @product.name = "Tulip"
      @product.quantity = nil
      @product.price_cents = 49.99
      @product.validate
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'is not valid without price_cents' do
      @category = Category.new 
      @category.name = 'flower'
      @product = @category.products.new
      @product.name = "Tulip"
      @product.quantity = 10
      @product.price_cents = nil
      @product.validate
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it 'is not valid without Category' do
      @category = Category.new 
      @category.name = 'flower'
      @product = @category.products.new
      @product.name = "Tulip"
      @product.quantity = 10
      @product.price_cents = 49.99
      @product.category = nil
      @product.validate
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
