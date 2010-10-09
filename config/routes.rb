Belcanto::Application.routes.draw do

  root :to => "home#index"
  get "home/index"
  match 'schedule' => 'home#schedule', :as => :schedule

  devise_for :users

  resources :students, :only => [:index, :edit, :update] do 
    collection do
      get :autocomplete_user_first_name
    end
  end

  resources :private_lessons
  resources :cms_pages
  
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
