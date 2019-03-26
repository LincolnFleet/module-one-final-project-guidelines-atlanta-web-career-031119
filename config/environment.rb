require 'bundler'
require 'open-uri'
require 'JSON'
require 'net/http'
require 'rake'
require 'rest-client'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'app'