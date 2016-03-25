module PartidoStepsHelper
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
