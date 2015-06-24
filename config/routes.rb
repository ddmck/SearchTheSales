Searchthesales::Application.routes.draw do

  resources :recommendations

  resources :messages

  resources :orders

  resources :sizes

  scope '/api' do 
    mount_devise_token_auth_for 'User', at: '/auth'

    mount_devise_token_auth_for 'Admin', at: 'admin_auth'
      as :admin do

    end
    post "auth/validate_token", to: "devise_token_auth/token_validations#validate_token"
    resources :orders
    resources :wishlist_items
    resources :messages
    get 'users', to: 'users#index', as: 'users_index'
    get 'users/:id', to: 'users#show', as: 'users_show'
    post 'messages/admin_message', to: 'messages#create_admin_message'
  end
  
  resources :features do
    resources :feature_links
  end

  resources :wishlist_items
  
  resources :data_feeds
  get '/get_data_feeds', to: 'data_feeds#get_feed_url', as: 'feed_url'
  resources :data_feed_xmls
  
  resources :genders

  resources :trends

  resources :sub_categories

  resources :styles

  resources :color_tags

  resources :colors

  resources :materials

  resources :categories

  # delete "/destroy_by_url", to: "products#destroy_by_url", constraints: { url: /[^\t\n\r]+/ }

  resources :products do
      delete "destroy_by_url", constraints: { url: /[^\t\n\r]+/ }, on: :collection
      member do
        get 'buy'
        post 'wish'
      end
  end

  get '/more_like_this', to: 'products#more_like_this', as: 'more_like_this'

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
    get 'posts/drafts', to: 'posts#drafts', as: 'posts_drafts'
    get 'posts/dashboard', to: 'posts#dashboard', as: 'posts_dashboard'
    resources :posts
  end

end
