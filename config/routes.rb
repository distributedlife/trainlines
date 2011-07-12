Trainmap::Application.routes.draw do
  root :to => "trainlines#show"

  resources :trainlines
end
