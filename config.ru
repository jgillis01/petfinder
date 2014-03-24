require 'rubygems'
require 'bundler'
require 'sass/plugin/rack'

Bundler.require

require './app.rb'
use Sass::Plugin::Rack
run Sinatra::Application
