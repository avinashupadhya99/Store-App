Rails.application.routes.draw do

	resources:customers

	resources:employees

	resources:orders

	resources:products

	resources:users, except:[:show, :index, :destroy]

	root 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
