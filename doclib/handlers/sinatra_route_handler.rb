module YARD::Handlers::Ruby
  class SinatraRouteHandler < Base
    HTTP_METHODS = %w(get post put delete head trace)
    handles method_call(*HTTP_METHODS)
    
    def process
      method = statement[0][0].upcase
      route = statement[1][0][0][0][0]
      
      register SinatraRoute.new(namespace, route) do |o|
        o.method = method
        o.route = route
        o.source = statement.source
      end
    end
  end
end