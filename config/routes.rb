Rails.application.routes.draw do
  constraints(SubdomainRoutes) do
    root to: "main#index", as: :main_index
  end

  constraints(!SubdomainRoutes) do
    resources :appoinments
    resources :hospitalizations
    resources :hospitals, only: [:edit, :update]
    resources :medical_consultations
    resources :patient_referrals
    resources :patients do
      get :weight, on: :member
      get :appoinments, on: :member
    end
    resources :referred_doctors

    root to: "main#hospital"
  end

  devise_for :users
end
