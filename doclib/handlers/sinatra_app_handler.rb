module YARD::Handlers::Ruby
  class SinatraAppHandler < ClassHandler
    handles :class
    
    def process
      superclass = parse_superclass(statement[1])
            
      if superclass == "Sinatra::Application"
        modname = statement[0].source
        app = register SinatraApp.new(namespace, modname)
        parse_block(statement[2], :namespace => app)
      end
    end
  end

end