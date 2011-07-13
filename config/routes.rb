Trainmap::Application.routes.draw do
  root :to => "trainlines#index"

  resources :trainlines do
    collection do
      get "routes"
    end

    member do
      put "discontinue"
      put "reinstate"
    end
  end
end
