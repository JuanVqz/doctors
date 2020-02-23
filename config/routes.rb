Rails.application.routes.draw do
  constraints(SubdomainRoutes) do
    root to: "main#index"
  end

  constraints(!SubdomainRoutes) do
    resources :appoinments
    resources :doctors
    resources :hospitalizations
    resources :hospitals, only: [:edit, :update]
    resources :medical_consultations
    resources :patients do
      get :weight, on: :member
      get :appoinments, on: :member
    end

    root to: "main#hospital"
  end

  devise_for :users
end
