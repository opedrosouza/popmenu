# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  scope :api, defaults: { format: :json } do
    resources :menus do
      resources :menu_items, controller: "menus/menu_items"
    end

    resources :menu_items, only: %i[index show]
  end
end
