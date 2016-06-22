Rails.application.routes.draw do
  devise_for :admins
  get 'admin', to: 'partidos#admin'

  resources :cargos
  resources :tipo_cargos
  resources :personas
  resources :afiliacions
  resources :sedes
  resources :tramites
  resources :acuerdos
  resources :eleccion_populars
  resources :eleccion_internas
  resources :procedimientos
  resources :requisitos
  resources :organo_internos
  resources :personas do
    collection { post :import_personas}
    collection { get :upload_foto }
  end
  resources :regions
  resources :comunas
  resources :distritos
  resources :circunscripcions
  resources :actividad_publicas

  resources :marco_internos
  resources :documentos
  resources :leys
  resources :marco_generals
  resources :partidos do
    resources :cargos
    resources :personas
    resources :tipo_cargos
    resources :regions
    resources :comunas
    resources :distritos
    resources :circunscripcions
    resources :actividad_publicas
    resources :sedes
  end

  scope "partido/:partido_id" do
    get 'export_personas', to: 'partido_steps#export_personas'
    resources :partido_steps
  end
  # resources :partido_steps
  get 'formulario/update_comunas', as: 'update_comunas'
  get 'formulario/update_distritos', as: 'update_distritos'
  # get 'partido_steps/update_comunas', as: 'update_comunas'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
