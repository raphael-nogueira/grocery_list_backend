# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read('.ruby-version').strip

gem "puma", "~> 6.5"
gem "rackup", "~> 2.2"
gem "sinatra", "~> 4.1"

group :development do
end

group :test do
end

group :production do
  gem "pg", "~> 1.5"
end
