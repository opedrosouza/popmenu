class ConvertService < Actor
  input :import, type: Import, allow_nil: true
  input :data, type: Hash, allow_nil: true, default: -> { {} }

  play LoadDataService, if: ->(actor) { actor.import.present? && actor.data.blank? }
  play ImportRestaurantsService
end
