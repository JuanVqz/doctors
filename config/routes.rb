Rails.application.routes.draw do
  constraints(SubdomainRoutes) do
    root to: "main#index"
  end

  constraints(!SubdomainRoutes) do
    resources :doctors
    resources :hospitalizations
    resources :hospitals, only: [:edit, :update]
    resources :medical_consultations
    resources :patients

    root to: "main#hospital"
  end

  devise_for :users
end
