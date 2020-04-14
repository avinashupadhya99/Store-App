Rails.application.routes.draw do

	resources:customers

	resources:employees

	resources:orders

	resources:products

	root 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
