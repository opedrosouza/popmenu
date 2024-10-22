namespace :data do
  desc "Import Restaurants Data"
  task :import_restaurants_data, [ :file_path ] => :environment do |_, args|
    start_time = Time.now
    Rails.logger.info("Importing Restaurants Data from #{args.file_path}")
    ConvertService.call(import: nil, file_path: args.file_path) if args.file_path
    Rails.logger.info("Importing Restaurants Data Completed in #{Time.now - start_time} seconds")
  end
end
