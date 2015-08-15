Rails.application.routes.draw do
  devise_for :users

  get 'reports/subjects', to: 'reports#subjects', as: 'report_subjects'
  get 'reports/tuition_payments', to: 'reports#tuition_payments', as: 'report_tuition_payments'

  resources :students do
    get :subjects
  end

  resources :teachers do
    get :subjects
  end

  root to: 'visitors#index'
end
