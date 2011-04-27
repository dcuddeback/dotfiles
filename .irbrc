require 'rubygems'
require 'irb/completion'

def load_gem(gem_name, options = {}, &block)
  require options[:require] || gem_name
  block.call if block_given?
rescue LoadError
  desc = options[:why?] ? " for #{options[:why?]}" : ""
  STDERR.puts "Unable to load #{gem_name}.  `gem install #{gem_name}`#{desc}."
end

load_gem 'wirble', :why? => 'colors' do
  Wirble.init
  Wirble.colorize
end

load_gem 'hirb', :why? => 'tableized outputs' do
  Hirb.enable
end

load_gem 'what_methods', :why? => 'finding useful methods'

if defined?(Rails)
  require 'logger'
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

# Toy data

class Array
  def self.toy
    10.times.map { rand(100) }
  end

  def toy
    self.class.toy
  end
end

class Hash
  def self.toy
    {
      :foo  => rand(100),
      :bar  => rand(100),
      :baz  => rand(100),
      :meh  => rand(100),
      :bleh => rand(100)
    }
  end

  def toy
    self.class.toy
  end
end
