# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version").strip

gem "activerecord", "~> 7.0"
gem "bcrypt", "~> 3.1"
gem "puma", "~> 6.2"
gem "rack-protection", "~> 3.0"
gem "rake", "~> 13.0"
gem "sinatra", "~> 3.0"
gem "sinatra-activerecord", "~> 2.0"
gem "sinatra-contrib", "~> 3.0"
gem "sinatra-flash", "~> 0.3.0"
gem "sysrandom", "~> 1.0"

group :development do
  gem "pry", "~> 0.14.2"
  gem "sqlite3", "~> 1.6"
end

group :test do
  gem "rack-test", "~> 2.1"
  gem "rspec", "~> 3.12"
  gem "rubocop", "~> 1.55", require: false
end
