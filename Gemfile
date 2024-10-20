source "https://rubygems.org"

gem "rails", "~> 7.2.1"
gem "sqlite3", ">= 1.4"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "active_model_serializers", "~> 0.10.14"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "factory_bot_rails", "~> 6.4", ">= 6.4.3"
  gem "faker", "~> 3.4", ">= 3.4.2"
end

group :test do
  gem "database_cleaner-active_record", "~> 2.2"
  gem "rails-controller-testing", "~> 1.0", ">= 1.0.5"
  gem "rspec-rails", "~> 7.0", ">= 7.0.1"
  gem "shoulda-matchers", "~> 6.4"
  gem "simplecov", "~> 0.22.0"
end

group :development do
  gem "annotate", "~> 3.2"
end
