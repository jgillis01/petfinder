# This is a test of the petfinder api
require 'httparty'
require './lib/pet_finder_api'
require './lib/helpers'

class PetFinder
  include Helpers

  def initialize(key)
    @host = 'http://api.petfinder.com' 
    @key = key
  end

  # Define api methods dynamically
  PetFinderAPI.constants.each do |const|
    endpoint = PetFinderAPI.module_eval const.to_s
    define_method Helpers.normalize(endpoint[:method]) do |arg|
      params = gather_params(default_params,arg,endpoint[:parameters])
      url = create_url(endpoint[:method],params)
      resp = HTTParty.get(url)
      resp.body
    end
  end

  private

  def default_params
    { key: @key, format: 'json' }
  end

  # Gather parameter hash 
  # Only select available parameters with values from the actual hash
  # default param is a Hash
  # actual param is a Hash
  # available param is an array of hashes
  def gather_params(default,actual,available)
    available.each do |param|
      name = param[:name]
      if actual.keys.include?(name)
        default[name] = actual[name]
      end
    end
    default
  end

  # Create URL for api call
  def create_url(method, arg)
    url_string = [@host,method].join('/')
    parameters = []

    arg.keys.each do |key|
      parameters << "#{key.to_s}=#{arg[key]}" 
    end

    [url_string,parameters.join('&')].join('?')
  end
end
