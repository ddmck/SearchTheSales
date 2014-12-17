Searchthesales::Application.routes.draw do
  scope '/api' do 
    mount_devise_token_auth_for 'User', at: '/auth' 
    resources :groups, except: [:new, :edit]
    post "auth/validate_token", to: "devise_token_auth/token_validations#validate_token" 
  end

  
  resources :features do
    resources :feature_links
  end
  
  resources :data_feeds

  resources :genders

  resources :trends

  resources :sub_categories

  resources :color_tags

  resources :colors

  resources :categories

  resources :products do
    member do
      get 'buy'
    end
  end

  resources :brands

  resources :stores

  root 'pages#home'
  get 'home', to: 'pages#home', as: 'home'
  get 'inside', to: 'pages#inside', as: 'inside'
  get '/contact', to: 'pages#contact', as: 'contact'
  post '/emailconfirmation', to: 'pages#email', as: 'email_confirmation'

  get 'posts', to: 'pages#posts', as: 'posts'
  get 'posts/:id', to: 'pages#show_post', as: 'post'

  namespace :admin do
    root 'base#index'
    resources :users
    get 'posts/drafts', to: 'posts#drafts', as: 'posts_drafts'
    get 'posts/dashboard', to: 'posts#dashboard', as: 'posts_dashboard'
    resources :posts
  end

end
