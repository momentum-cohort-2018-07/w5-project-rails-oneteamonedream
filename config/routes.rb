Rails.application.routes.draw do
  
  resource :session, only: [:new, :create, :destroy]
  resources :users



  root 'posts#index'
  resources :comments


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts do
    member do
      put "like" => "posts#vote"
    end
  end

end
