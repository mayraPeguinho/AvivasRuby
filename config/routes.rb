Rails.application.routes.draw do
  resources :sales
  resources :products do
    member do
      get :edit_stock  # Nueva ruta para editar solo el stock
      patch :update_stock  # Ruta para actualizar solo el stock
    end
  end
  resources :sizes
  resources :categories
  resources :colors
  resources :product_variants, only: [:index] 
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  get "home/index"
  root "home#index"

  resources :users, only: [ :index, :edit, :update ] do
    member do
      patch :activate
      patch :deactivate
    end
  end
end
