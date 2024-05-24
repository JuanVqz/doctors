# frozen_string_literal: true

Rails.application.routes.draw do
  constraints(SubdomainRoutes) do
    root to: 'main#index', as: :main_index
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

    devise_for :users
    root to: 'main#hospital'
  end
end
