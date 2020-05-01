Rails.application.routes.draw do

	resources:customers, except:[:destroy]

	resources:employees, except:[:destroy]

	resources:orders, except:[:index, :show]

	resources:products

	resources:aggregated_orders, except:[:edit, :update, :destroy]

	resources:discounts, except:[:show]

	resources:users, except:[:show, :index]
	
	get 'login', to: 'sessions#new'

  	post 'login', to: 'sessions#create'

  	delete 'logout', to: 'sessions#destroy'

  	get 'editPassword' => 'users#editPassword'

  	post 'editPassword' => 'users#updatePassword'

  	get 'search_customers', to: 'customers#search'

  	get 'search_products', to: 'products#search'

	root 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
