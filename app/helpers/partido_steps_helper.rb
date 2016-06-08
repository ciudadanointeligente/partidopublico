module PartidoStepsHelper

    def main_menu
      step_categories = ["inicio", "normas internas y pensamiento", "presencia nacional", "cómo participar", "últimas decisiones", "vínculos e intereses", "denuncias y sanciones", "finanzas"]
    end

    def sub_menu
      step_categories = main_menu
      step_organisation = { step_categories[0] => ["datos_basicos", "personas", "cargos"],
                            step_categories[1] => ["normas_internas"],
                            step_categories[2] => ["regiones", "sedes", "num_afiliados", "tramites", "representantes", "autoridades" ],
                            step_categories[3] => ["postulacion_popular", "organos_internos", "postulacion_interna", "agenda_presidente", "actividades_publicas" ],
                            step_categories[4] => ["candidatos", "acuerdos_organos", "resultados_elecciones_internas"],
                            step_categories[5] => ["entidades_participadas", "pactos_electorales"],
                            step_categories[6] => ["linea_denuncia", "sanciones"],
                            step_categories[7] => ["a","b"]}
    end

    def substeps_progress_bar
      step_organisation = sub_menu

      key = step_organisation.select{|k,v| v.include? step.to_s}.keys.first
      values = step_organisation.select{|k,v| v.include? step.to_s}.values.first

        content_tag(:div, class: "navigator container") do
          content_tag(:ul, class: "nav nav-pills list-inline") do
            values.each do |sub_step|
              class_str = "unfinished"
              class_str = "active"  if sub_step == step.to_s
              concat(
                content_tag(:li, class: class_str) do
                  link_to (sub_step), wizard_path(sub_step), :target => "_self"
                end
              )
            end
          end
        end
    end


    def steps_progress_bar
      step_organisation = sub_menu
      step_categories = main_menu

      key = step_organisation.select{|k,v| v.include? step.to_s}.keys.first
      values = step_organisation.select{|k,v| v.include? step.to_s}.values.first

        content_tag(:div, class: "navigator container") do
          content_tag(:ul, class: "nav nav-pills list-inline") do
            step_categories.each do |main_step|
              class_str = "unfinished"
              class_str = "active"  if main_step == key
              concat(
                content_tag(:li, class: class_str) do
                  link_to (main_step), wizard_path(step_organisation[main_step].first), :target => "_self"
                end
              )
            end
          end
        end
    end

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
