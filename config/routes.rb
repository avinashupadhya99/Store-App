Rails.application.routes.draw do

	resources:customers

	resources:employees

	resources:orders

	resources:products

	resources:users, except:[:show, :index, :destroy]
	
	get 'login', to: 'sessions#new'

  	post 'login', to: 'sessions#create'

  	delete 'logout', to: 'sessions#destroy'

  	get 'editPassword' => 'users#editPassword'

  	post 'editPassword' => 'users#updatePassword'

	root 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
