# encoding: utf-8

module Nestive
  class Railtie < Rails::Railtie
    initializer 'nestive.initialize' do
      ActiveSupport.on_load(:action_view) do
        include Nestive::LayoutHelper
      end
    end
  end
end
