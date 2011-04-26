if defined?(Rails) && Rails.version.to_i >= 3
  module Nestive
    class Engine < Rails::Engine
    end
  end
end
