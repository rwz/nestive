class NestiveController < ApplicationController
  def extended_one
    render layout: 'extend_one'
  end
  
  def extended_two
    render layout: 'extend_two'
  end
end