class Admin::ItemCategoriesController < ApplicationController
  layout "admin"

  before_action :set_category, only: [:new, :edit, :update]
  before_action :item_options, :new
  before_action :is_admin?

  def new
    @item_category = ItemCategory.new(category_id: params[:category_id])
  end

  def edit
  end

  def create
    @item_category = ItemCategory.new(category_id: params[:item_category][:category_id], item_id: params[:item_category][:item_id])
    category = Category.find(@item_category.category_id)

    if @item_category.save
      flash[:notice] = "Category updated!"
      redirect_to admin_category_path(category)
    else
      flash[:notice] = "Item already exists in this Category"
      redirect_to(:back)
    end
  end

  def update
  end

  def destroy
    @item = Item.find(params[:item_id])
    @category = Category.find(params[:category_id])

    @item.categories.delete(@category)
    flash[:notice] = "#{@item.name} removed from category"

    redirect_to admin_category_path(@category)
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def item_options
    @item_options = Item.all.map { |item| [item.name, item.id] }
  end
end
