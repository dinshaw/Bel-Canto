Belcanto::Application.routes.draw do
  resources :private_lessons

  resources :cms_pages

  get "home/index"
  match 'schedule' => 'home#schedule', :as => :schedule

  devise_for :users

  # The priority is based upon order of creation:
  # first created -> highest priority.
  root :to => "home#index"

  resources :students, :only => [:index, :edit, :update]
  
  resources :files, :only => [:index] do
    member do
      get :download
    end
  end
  
  namespace :admin do
    get '/', :to => "base#index"
    resources :uploads
    resources :students do
      member do
        get :transition
      end
    end
  end
end
