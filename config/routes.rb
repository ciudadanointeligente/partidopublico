Rails.application.routes.draw do
  resources :balance_anuals
  resources :egreso_ordinarios
  resources :ingreso_ordinarios
  devise_for :admins
  get 'admin', to: 'partidos#admin'

  resources :cargos
  resources :tipo_cargos
  resources :personas
  resources :afiliacions do
    collection { post :import_afiliacion}
    collection { get :aggregate }
  end
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
  resources :ingreso_ordinarios do
    collection {post :import_ingresos_ordinarios}
  end
  resources :egreso_ordinarios do
    collection {post :import_egresos_ordinarios}
  end
  resources :balance_anuals do
    collection {post :import_balance_anual}
  end
  #resources :regions
  #resources :comunas
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
    resources :regions do
      resources :comunas
    end
    resources :distritos
    resources :circunscripcions
    resources :actividad_publicas
    resources :sedes
    resources :afiliacions do
      collection { get :aggregate }
      collection { post :eliminar }
    end
    resources :ingreso_ordinarios do
      collection { get :aggregate_ingresos_ordinarios }
      collection { post :eliminar }
    end
    resources :egreso_ordinarios do
      collection { get :aggregate_egresos_ordinarios }
      collection { post :eliminar }
    end
    resources :balance_anuals do
      collection { get :aggregate_balance_anual }
      collection { post :eliminar }
    end
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
end
