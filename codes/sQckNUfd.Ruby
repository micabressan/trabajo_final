Rails.application.routes.draw do
  concern :paginatable do
    get 'page/:page', action: :page, on: :collection
  end

  get 'history/:id', to: 'audited/audits#show'
  scope module: 'audited' do
    resources 'audits', only: [:page], path: 'history', concerns: [:paginatable]
  end

  root to: 'application#index'

  get 'object_types', to: 'object_types#index'

  get 'flush', to: 'flush#index'
  put 'flush', to: 'flush#refresh'

  put 'autofill_engine/import_autofill', to: 'autofill_engine#import_autofill'

  post 'drills/hide_page/:id', to: 'drills#hide_page'
  get 'drills/get_drills_for_portal/:portal_id', to: 'drills#get_drills_for_portal'

  get '/auth', to: 'auth#index'
  scope path: '/auth' do
    post '/:provider/callback', to: 'auth#callback'
    get '/:provider/callback', to: 'auth#callback'
  end

  resources :portals, concerns: [:paginatable] do
    resources :pages, :hero_objects, :external_links, only: [:index],
      concerns: [:paginatable]
  end

  resources :stack_modules, only: [:create, :update, :destroy] do
    collection do
      put 'desktop', 'tablet', 'mobile'
    end
  end

  resources :manual_selections, only: [:create, :update, :destroy] do
    put :sort, on: :collection
  end

  namespace :objects do
    resources :books, :bundles, :characters, :games, :movies, :properties,
      :publishers, :shops, :lists, :shows, :soundtracks, :videos,
      concerns: [:paginatable]
  end

  resources :admins, :banners, :css_banners, :d_modules, :global_footers,
    :external_links, :hero_objects, :drills, :video_prerolls, :chrome_links, concerns: [:paginatable]

  resources :meta_info, only: [:index, :show] do
    collection do
      get '/property/:property', to: 'meta_info#by_property'
      #@todo: hmm....
      get '/property/:property/availability/:availability', to: 'meta_info#by_property_and_availability'
    end
  end

  resources :pages, concerns: [:paginatable] do
    member do
      post :draft, to: 'pages#create_draft'
      get 'drafts/page/:page', to: 'pages#page_draft'
      delete 'drafts/:draft_id', to: 'pages#destroy_draft'
      put 'draft', to: 'pages#publish_draft'
    end
  end

  resources :autofill_selections, only: [:show, :update],
    concerns: [:paginatable]
end