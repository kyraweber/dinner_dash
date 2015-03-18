require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }

  it "has a defualt status of ordered" do
    expect(order.status).to eq("ordered")
  end

  it "belongs to a user" do
    user = create(:user)
    user.orders.create(status:0, cart: {"1" => 3} )
    expect(Order.first.user_id).to eq(user.id)
  end

  it "has a cart" do
    expect(order.cart).to eq({"1"=>"3", "2"=>"3", "3"=>"3"})
  end

  describe ".generate_order" do
    it "creates an order from the cart" do
      expect(Order.count).to eq(0)

      user = create(:user)
      cart = {"1"=>"3", "2"=>"3", "3"=>"3"}
      Order.generate_order(user, cart)

      expect(Order.count).to eq(1)
      expect(user.orders.first.cart).to eq(cart)
    end

  end

end
