# == Schema Information
#
# Table name: menus
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :menu do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end

  trait :with_menu_items do
    after(:create) do |menu|
      create_list(:menu_item, 3, menu: menu)
    end
  end
end
