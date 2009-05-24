require 'rubygems'
#gem 'inochi', '~> 0'
#require 'inochi'
#
#Inochi.rake :TsungStatsServer, 
#            :rubyforge_project => 'skadesgems',
#            :rubyforge_section => 'tsung_stats_server'
            
module YARD
  module CodeObjects
    autoload :SinatraRoute, 'doclib/code_objects/sinatra_route'
    autoload :SinatraApp, 'doclib/code_objects/sinatra_app'
  end
  
  module Handlers 
    module Ruby
      autoload :SinatraRouteHandler, 'doclib/handlers/sinatra_route_handler'
      autoload :SinatraAppHandler, 'doclib/handlers/sinatra_app_handler'
    end
  end
end

require 'yard'

require 'doclib/tags/register_tags'

YARD::Rake::YardocTask.new
