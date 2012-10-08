GovSchoolApplication::Application.routes.draw do
  

  get "teacher_recommendations/new"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users

  resources :applicants, :schools, :teacher_recommendations, :coordinator
  
  namespace :coordinator do
    resources :applicants, :only => [:edit, :update, :show, :index]
    resources :teacher_recommendations, :only => [:new, :create]
  end
  
  get "static_pages/info"
  
  root to: 'static_pages#info'
  
  match '/mission', to: 'static_pages#mission'
  
  match '/how', to: 'static_pages#how'
  
  match 'instructions', to: 'static_pages#instructions'
  
  match 'thank_you', to: 'static_pages#thank_you'
  
  match 'thanks', to: 'static_pages#thank_you_teacher'
  
  match 'teachers', to: 'applicants#teacher_invite'
  
  match 'success', to: 'static_pages#success'
  
  #match '/applicant', to: 'applicants#new', :as => 'applicant', :via => :get
  #match '/applicant', to: 'applicants#create', :as => 'applicant', :via => :post
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
