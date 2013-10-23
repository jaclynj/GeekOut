IntoverseApp::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

root to: 'homepages#index'
match '/results' => 'homepages#results', :via => :get

resources :places
resources :tags, :except => :edit, :except => :update

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

  # See how all your routes lay out with "rake routes"
end
