Rails.application.routes.draw do
	root to: "top#index"
	resources :scrapings

	get "/" => "top#index"
end
