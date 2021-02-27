Rails.application.routes.draw do
  get 'addresses/find(/:ip)' => 'addresses#find'
  get 'addresses/show(/:city)(/:country)' => 'addresses#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
