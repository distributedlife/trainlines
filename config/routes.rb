Trainmap::Application.routes.draw do
  root :to => "index#index"

  resources :index
end
