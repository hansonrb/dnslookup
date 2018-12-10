Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "domains#index"

  resources :domains do
    post 'process_dns', on: :member
  end
end
