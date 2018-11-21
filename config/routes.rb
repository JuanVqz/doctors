Rails.application.routes.draw do
  constraints(SubdomainRoutes) do
    root to: "main#index"
  end

  constraints(!SubdomainRoutes) do
    authenticated :user do
      resources :doctors
      resources :hospitalizations
      resources :medical_consultations
      resources :patients do
        get :hospitalizations, on: :member
        get :medical_consultations, on: :member
      end
      root to: "dash#index", as: :dash
    end

    root to: "main#index"
  end

  devise_for :users
end
