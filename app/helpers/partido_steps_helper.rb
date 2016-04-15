module PartidoStepsHelper
  
    main_steps = %w(1 2 3 4 5 6 7)
    step_organisation = {
     main_steps[0] => [:regiones, :sedes, :num_afiliados], 
     main_steps[1] => ["c"], 
     main_steps[2] => ["a", "d", "f", "g"], 
     main_steps[3] => ["q"]
    } 
    map_steps = {:datos_basicos, :normas_internas, :regiones, :sedes, :num_afiliados, :tramites, :representantes, :autoridades, :postulacion_popular, :postulacion_interna, :acuerdos, :afiliacion}
    def tutorial_progress_bar
      content_tag(:section, class: "content") do
        content_tag(:div, class: "navigator") do
          content_tag(:ol, class: "steps_list") do
            wizard_steps.collect do |every_step|
              class_str = "unfinished"
              class_str = "current"  if every_step == step
              class_str = "finished" if past_step?(every_step)
              concat(
                content_tag(:li, class: class_str) do
                  link_to (every_step), wizard_path(every_step)
                end 
              )   
            end 
          end 
        end
      end
    end 
end
