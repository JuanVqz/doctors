Rails.application.routes.draw do
  constraints(SubdomainRoutes) do
    root to: "main#index", as: :main_index
  end

  constraints(!SubdomainRoutes) do
    resources :appointments
    resources :hospitalizations
    resources :hospitals, only: %i[edit update]
    resources :patient_referrals
    resources :patients do
      resources :appointments, module: :patients, only: %i[index new]
      resources :information, module: :patients, only: %i[index]
    end
    resources :referred_doctors

    root to: "main#hospital"
  end

  devise_for :users
end
