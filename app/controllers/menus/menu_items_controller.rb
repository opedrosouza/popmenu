class Menus::MenuItemsController < ApplicationController
  def index
    render json: menu_items
  end

  def show
    render json: menu_items.find(params[:id])
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
end
