Rails.application.routes.draw do
  root "pages#home"
  get "how-i-work", to: "pages#how", as: :how
  get "about", to: "pages#about"
  get "privacy", to: "pages#privacy"
  resources :posts, only: %i[index show], path: "writing"
  resource :introduction, only: %i[new create], path: "introduction" do
    get :thanks
  end
  namespace :admin do
    root to: "leads#index"
    resources :leads, only: %i[index show update]
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
