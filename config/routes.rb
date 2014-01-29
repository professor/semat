SEMAT::Application.routes.draw do


  constraints(:host => /essence.sv.cmu.edu/) do
    match "/(*path)" => redirect {|params, req| "http://semat.herokuapp.com/#{params[:path]}"}, via: [:get, :post]
  end

  constraints(:host => /essence.ece.cmu.edu/) do
    match "/(*path)" => redirect {|params, req| "http://semat.herokuapp.com/#{params[:path]}"}, via: [:get, :post]
  end

  
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => { :registrations => "registrations" }

  root :to => "welcome#index"
  get "/state" => "welcome#state"  #Just for convenience

  resources :teams
  get "teams/:team_id/alphas" => "alphas#index", as: :update_progress
  get "snapshots/:snapshot_id" => "alphas#version", as: :snapshot

  get "teams/checklists"
  post "teams/:team_id/mass_invite" => "teams#mass_invite", as: :mass_invite
  get "alphas" => "alphas#index"

  get "simple_alphas" => "alphas#simple_index"
  get "users/:email/teams" => "users#my_teams", as: :my_teams, :email => /[A-Za-z0-9@\.]+?/
  get "/admin/users/:email" => "admin/users#show", as: :admin_user_path, :email => /[A-Za-z0-9@\.]+?/
  get 'static/about' => 'static#about', as: :about
#  get 'static/:action' => 'static#:action'

  get "versions" => "versions#index", as: :versions
  get "versions/:name" => "versions#show", as: :version, :name => /[^\/]+/
  get "/admin/versions/:name" => "versions#show", as: :admin_essence_version_path, :name => /[^\/]+/

  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
       # Directs /admin/products/* to Admin::ProductsController
       # (app/controllers/admin/products_controller.rb)
       resources :alphas
       get "versions" => "versions#index", as: :versions
       get "versions/:name" => "versions#show", as: :version, :name => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/
       devise_scope :user do
         post 'sessions' => 'sessions#create', :as => 'login'
         delete 'sessions' => 'sessions#destroy', :as => 'logout'
       end
       get "simple_alphas" => "alphas#simple_index"
       post "progress/:team_id/mark" => "progress#mark"
       post "progress/:team_id/save_notes" => "progress#save_notes"
       post "progress/:team_id/save_actions" => "progress#save_actions"
       post "progress/:team_id/action_done" => "progress#action_done"
       post "progress/:team_id/action_deleted" => "progress#action_deleted"
       post "progress/:team_id/email_summary" => "progress#email_summary"
       get "progress/:team_id" => "progress#show"
       get "progress/:team_id/current_alpha_states" => "progress#current_alpha_states"
       get "users/:email/teams" => "users#my_teams", as: :my_teams, :email => /[A-Za-z0-9@\.]+?/
       post "users/find_or_register" => "users#find_or_register"
       post "teams/:team_id/rename" => "teams#rename"
       post "teams/:team_id/add_member" => "teams#add_member"
       post "teams/:team_id/remove_member" => "teams#remove_member"
       get "test/get" => "test#get"
       post "test/post" => "test#post"
    end
  end


#  get "alphas/show"

#  get "alphas/show"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
