require 'rubygems'
require 'bundler/setup'
require 'simplecov'
require 'rspec-spies'
require 'rspec-given'
require 'codeclimate-test-reporter'
require 'sidekiq'
require 'sidekiq/testing'

Sidekiq::Testing.inline!
SimpleCov.start
CodeClimate::TestReporter.start

require 'event_bus'
require 'event_bg_bus'
