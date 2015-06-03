require 'rubygems'
require 'irb/completion'

if defined?(Rails)
  require 'logger'
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end
