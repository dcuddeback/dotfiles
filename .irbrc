require 'rubygems'
require 'irb/completion'

IRB.conf[:AUTO_INDENT] = true

begin
  require 'wirble'
  Wirble.init
  Wirble.colorize
rescue LoadError
  STDERR.puts "Unable to load wirble.  `gem install wirble` for colors."
end
