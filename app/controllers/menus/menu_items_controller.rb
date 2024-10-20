class Menus::MenuItemsController < ApplicationController
  def index
    render json: menu_items
  end

  def show
    render json: menu_items.find(params[:id])
  end

  def create
    @menu_item = menu.menu_items.new(menu_item_params)
    if @menu_item.save
      @menu_item.menus << menu
      render json: @menu_item, status: :created
    else
      render json: { errors: @menu_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if menu_item.update(menu_item_params)
      render json: menu_item
    else
      render json: { errors: @menu_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    menu_item.destroy
  end

  private

  def menu
    @menu ||= Menu.find(params[:menu_id])
  end

  def menu_items
    @menu_items ||= menu.menu_items
  end

  def menu_item
    @menu_item ||= menu_items.find(params[:id])
  end

  def menu_item_params
    params.require(:menu_item).permit(:name, :description, :price)
  end
end
