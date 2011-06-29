DocHuts::Application.routes.draw do
  resources :huts, :only => [:index, :show]
  root :to => "huts#index"
end
