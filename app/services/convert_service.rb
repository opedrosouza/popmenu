class ConvertService < Actor
  input :import, type: Import, allow_nil: true
  input :data, type: Hash, allow_nil: true, default: -> { {} }
  input :file_path, type: String, allow_nil: true, default: -> { nil }

  play ->(actor) { Rails.logger.info("Loading and Parsing Data") }
  play LoadDataService, if: ->(actor) { actor.import.present? && actor.data.blank? }
  play LoadFileService, if: ->(actor) { actor.file_path.present? && actor.data.blank? }
  play ->(actor) { Rails.logger.info("Importing Restaurants") },
  ImportRestaurantsService,
  ImportMenusService,
  ImportMenuItemsService
end
