class ImportRestaurantsService < Actor
  input :data, type: Hash
  output :restaurants, type: Array

  def call
    ActiveRecord::Base.transaction do
      self.restaurants = data[:restaurants].pluck(:name).map! do |name|
        Restaurant.find_or_create_by(name:)
      end
    end
  end
end
