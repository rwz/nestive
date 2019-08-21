# frozen_string_literal: true

require 'rails/railtie'

module NestiveRails
  class Railtie < Rails::Railtie
    initializer 'nestive-rails.action_view' do
      ActiveSupport.on_load :action_view do
        include NestiveRails::LayoutHelper
      end
    end
  end
end
