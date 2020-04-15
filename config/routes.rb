Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    resource :convert, only: :create
  end
end
