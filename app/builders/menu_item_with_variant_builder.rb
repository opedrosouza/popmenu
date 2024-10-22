class MenuItemWithVariantBuilder
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :menu, :params

  validates :menu, :params, presence: true
  validate :validate_params

  def build
    return unless valid?

    menu.transaction do
      menu_item = MenuItem.find_or_initialize_by(name: params[:name])
      menu_item_variant = menu.menu_item_variants.build(menu_item: menu_item, price: params[:price])
      menu_item.save! unless menu_item.persisted?
      menu_item_variant.save!

      return { menu_item_variant:, menu_item: }
    end
  end

  private

  def validate_params
    return if params[:name].present? && params[:price].present?

    errors.add(:params, "name and price are required")
  end
end
