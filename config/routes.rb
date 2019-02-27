Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "home#index", as: :root
    resources :task, controller: 'task', :only => [:index, :create, :destroy], path_names: {index: 'index'}

  end

  unauthenticated :user do
    root to: "home#index_anonymous", as: :root_anonymous
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
