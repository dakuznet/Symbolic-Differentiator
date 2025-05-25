# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'sinatra'
require 'rake'

task :web do
    require './web/app.rb'
    DiffApp.run!(server: 'webrick')
  end

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]
