require "sidekiq/web"

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  mount Shrine.presign_endpoint(:cache), at: "/s3/params"

  match "(*any)", to: redirect(subdomain: ""), via: :all, constraints: { subdomain: "www" }

  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_for :users,
    path: "",
    path_names: { sign_in: "login", sign_out: "logout", sign_up: "signup" },
    skip: :omniauth_callbacks,
    controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  
  resources :pages, param: :slug, only: :show
  resources :news, only: [:index, :show]

  resource :profile, only: [:new, :create]

  resources :packages do
    collection do
      get "expected"
      get "warehouse"
      get "in_transit"
      get "arrived"
    end
  end

  get "contacts", to: "pages#contacts"
  get "stores", to: "pages#stores"
  get "find_tracking", to: "pages#find_tracking"
  get "turkey", to: "pages#turkey"
  get "us_address", to: "pages#us_address"

  namespace :admin do
    root "packages#index"
    resources :users, only: [:index, :edit, :update] do
      member do
        get "become"
      end
    end

    resources :packages do
      get "new_or_edit", on: :collection
      get "set_as_received", on: :collection
      get "cn23", on: :member
    end

    resources :shipments do
      get "pending_invoice", on: :collection
      member do
        get "invoice"
        get "list_cp71"
        get "invoice_register"
        patch "set_as_in_transit"
        patch "set_as_arrived"
      end
    end

    resources :pages, except: :show
    resources :news, except: :show

    resource :shipment_next_date, only: :update

    resources :autocomplete_package_item_descriptions, only: [:index, :create, :destroy]
    
    post "autocomplete_find_user", to: "autocomplete#find_user"
    post "autocomplete_first_name", to: "autocomplete#first_name"
    post "autocomplete_last_name", to: "autocomplete#last_name"
    post "autocomplete_package_description", to: "autocomplete#package_description"
  end

  root "pages#index"

  authenticate :user, ->(user) { user.super_admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end
end
