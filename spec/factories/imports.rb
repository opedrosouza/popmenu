# == Schema Information
#
# Table name: imports
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :import do
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'restaurant_data.json'), 'application/json') }
  end
end
