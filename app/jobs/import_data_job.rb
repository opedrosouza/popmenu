class ImportDataJob < ApplicationJob
  queue_as :default

  def perform(import:)
    ConvertService.call(import:)
  end
end
