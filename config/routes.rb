Trainmap::Application.routes.draw do
  root :to => "trainlines#index"

  resources :trainlines do
    collection do
      resources :stops
      
      get "routes"
      get "search"
    end

    member do
      put "discontinue"
      put "reinstate"
    end
  end
end
