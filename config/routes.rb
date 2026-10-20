Rails.application.routes.draw do
  root "pages#home"
  get "how-i-work", to: "pages#how", as: :how
  get "about", to: "pages#about"
  get "privacy", to: "pages#privacy"
  resources :posts, only: %i[index show], path: "blog"
  get "writing", to: redirect("/blog")
  get "writing/:id", to: redirect("/blog/%{id}")
  resource :introduction, only: %i[new create], path: "introduction" do
    get :thanks
  end
  namespace :admin do
    root to: "leads#index"
    resources :leads, only: %i[index show update]
    resources :posts, only: :show
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
