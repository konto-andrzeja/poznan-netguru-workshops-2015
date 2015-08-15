Rails.application.routes.draw do
  devise_for :users

  get 'reports/subjects', to: 'reports#subjects', as: 'report_subjects'

  resources :students do
    get :subjects
  end

  resources :teachers do
    get :subjects
  end

  root to: 'visitors#index'
end
