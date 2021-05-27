Rails.application.routes.draw do
  %w[
    index
    append
    prepend
    replace
    purge_single
    purge_multiple
    extended_one
    extended_two
    extended_three
    extended_without_yield
  ].each do |action|
    get "nestive/#{action}", to: "nestive##{action}"
  end
end
