module YARD
  module Tags
    class Library
      define_tag "Matched URL Parameters", :url_param       , :with_name
      define_tag "GET Parameters"        , :get             , :with_name
      define_tag "POST Parameters"       , :post            , :with_name
      define_tag "Output Types"          , :output_types    , :with_types
      define_tag "Output Languages"      , :output_languages, :with_types
    end
  end
end