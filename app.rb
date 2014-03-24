require 'rubygems'
require 'haml'
require 'sinatra'
require './navigation'
require './lib/pet_finder'
require './lib/geocoder'
require 'json'
require 'yaml'
require 'pry'

# set sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, "views"
set :haml, :layout_engine => :erb, :layout => :default
set :app_config, YAML::load_file('./config.yml')

# default route
get '/' do
  redirect "/#{navigation.first[:link]}"
end

# Handle all defined routes
navigation.each do |route|
  get "/#{route[:link]}" do
    haml route[:link].to_sym
  end
end

# PetFinder entry point
get '/api/petfinder/:method' do
  method = params[:method]
  key = settings.app_config['pet_finder']['key']

  # Delete unwanted parameters
  %w{method captures splat}.each do |param|
    params.delete param
  end

  PetFinder.new(key).send method.to_sym, params
end

# Geocoding for google maps integration
get '/api/geocoder/:zipcode' do
  {:geocoder => GeoCoder.new.geoencode(params[:zipcode])}.to_json
end
