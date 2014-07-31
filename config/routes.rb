Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :genomes, only: [:new, :create] do
    get 'new_callback', on: :collection
  end

  root :to => 'sessions#new'

  get '/login' => 'sessions#new'

  post '/login' => 'sessions#create'

  get '/logout' => 'sessions#destroy'

  resources :categories

  resources :diseases

  resources :risks

  get '/testing' => "welcome#testing"

  get '/sunburst' => 'welcome#sunburst'

  get '/search/top_10' => 'searches#search_top_diseases_by_risk_level'

  get '/search/bottom_10' => 'searches#search_bottom_diseases_by_risk_level'

  get '/search' => 'searches#search'

  get '/barchart/:id' => "diseases#barchart"

  get 'user/profile' => 'users#show',
    as: 'user'

end
