module YARD::Handlers::Ruby
  class SinatraAppHandler < ClassHandler
    handles :class
    
    def process
      superclass = parse_superclass(statement[1])
      
      #TODO: Fix that pesky parser and change this to Sinatra::Application
      if superclass == "SinatraApplication"
        modname = statement[0].source
        app = register SinatraApp.new(namespace, "sinatra::#{modname}")
        parse_block(statement[2], :namespace => app)
      end
    end
  end

end