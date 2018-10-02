Rails.application.routes.draw do

  resources :lists do
      resources :telefones do
        resources :colabs
      end
  end

  resources :lists do
     patch :clear 
     put :clear
     get :clear
     post :clear
  end

  get '/autocomplete' => 'lists#autocomplete'

  resources :lis do
    collection do
      get 'get_tels', to: "lis#get_tels"
    end 
  end

  devise_for :users
	
	authenticated :user do
    	root 'admin#index', as: :authenticated_root
  	end

	root 'lists#index'
	get '/admin' => 'admin#index'
	delete '/admin' => 'admin#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
