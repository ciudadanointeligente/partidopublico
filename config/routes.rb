Rails.application.routes.draw do
  #get 'compare', to: 'comparisons#index'
  resources :comparisons
  resources :egreso_campanas
  resources :ingreso_campanas
  resources :transferencias
  resources :contratacions
  resources :balance_anuals
  resources :egreso_ordinarios
  resources :ingreso_ordinarios
  devise_for :admins, :skip => [:registrations]
  get 'admin', to: 'partidos#admin'

  resources :cargos
  resources :tipo_cargos
  resources :personas
  resources :afiliacions do
    collection { post :import_afiliacion}
    collection { get :aggregate }
  end
  resources :sedes
  resources :regions
  get 'all_regions', to: 'regions#all'
  resources :circunscripcions do
    resources :distritos
  end
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
  resources :contratacions do
    collection {post :import_contrataciones}
  end
  resources :transferencias do
    collection {post :import_transferencias}
  end
  resources :ingreso_campanas do
    collection {post :import_ingresos_campanas}
  end
  resources :egreso_campanas do
    collection {post :import_egresos_campanas}
  end
  #resources :regions
  #resources :comunas
  resources :distritos
  resources :circunscripcions
  resources :actividad_publicas, only: [:index, :show]

  resources :marco_internos
  resources :documentos
  resources :leys
  resources :marco_generals
  resources :partidos do
    get "/normas_internas", to: 'partidos#normas_internas'
    get "/regiones", to: 'partidos#regiones'
    get "/sedes_partido", to: 'partidos#sedes_partido'
    get "/autoridades", to: 'partidos#autoridades'
    get "/representantes", to: 'partidos#representantes'
    get "/vinculos_e_intereses", to: 'partidos#vinculos_intereses'
    get "/pactos", to: 'partidos#pactos'
    get "/sanciones", to: 'partidos#sanciones'
    get "/finanzas_1", to: 'partidos#finanzas_1'
    get "/finanzas_2", to: 'partidos#finanzas_2'
    get "/finanzas_5", to: 'partidos#finanzas_5'
    get "/afiliacion_desafiliacion", to: 'partidos#afiliacion_desafiliacion'
    get "/eleccion_popular", to: 'partidos#eleccion_popular'
    get "/organos_internos", to: 'partidos#organos_internos'
    get "/elecciones_internas", to: 'partidos#elecciones_internas'
    get "/acuerdos_organos", to: "partidos#acuerdos_organos"
    get "/estructura_organica", to: "partidos#estructura_organica"
    get "/actividades_publicas", to: "partidos#actividades_publicas"
    get "/intereses_patrimonios", to: "partidos#intereses_patrimonios"
    get "/publicacion_candidatos", to: "partidos#publicacion_candidatos"
    get "/resultado_elecciones_internas", to: "partidos#resultado_elecciones_internas"
    resources :cargos
    resources :personas
    resources :tipo_cargos
    resources :organo_internos
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
    resources :contratacions do
      collection { get :aggregate_contrataciones }
      collection { post :eliminar }
    end
    resources :transferencias do
      collection { get :aggregate_transferencias }
      collection { post :eliminar }
    end
    resources :ingreso_campanas do
      collection { get :aggregate_ingresos_campanas }
      collection { post :eliminar }
    end
    resources :egreso_campanas do
      collection { get :aggregate_egresos_campanas }
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
  get 'que-es', to: 'welcome#que_es'
end
