Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # Mount Grape API
  mount Api::V1::Base => "/"

  mount Rswag::Ui::Engine, at: "/api-docs"
  mount Rswag::Api::Engine, at: "/api-docs"
end
