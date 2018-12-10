Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :domains do
    post 'process_dns', on: :member
  end
end
