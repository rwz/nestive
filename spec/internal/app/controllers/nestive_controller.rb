class NestiveController < ApplicationController
  def extended_one
    render layout: 'extend_one'
  end

  def extended_two
    render layout: 'extend_two'
  end

  def extended_three
    render layout: 'extend_one'
  end

  def extended_without_yield
    render layout: 'extend_without_yield'
  end
end
