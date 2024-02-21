Rails.application.routes.draw do
  constraints(SubdomainRoutes) do
    root to: "main#index", as: :main_index
  end

  constraints(!SubdomainRoutes) do
    resources :appoinments
    resources :hospitalizations
    resources :hospitals, only: [:edit, :update]
    resources :patient_referrals
    resources :patients
    resources :referred_doctors

    root to: "main#hospital"
  end

  devise_for :users
end
