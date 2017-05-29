class PagesController < ApplicationController
  def twittea
    @partidos = Partido.all
    render layout: "welcome"
  end

  def proyecto
    @partidos = Partido.all
    render layout: "welcome"
  end

  def manual
    send_file "#{Rails.root}/public/Manual-de-Transparencia-Activa-para-Partidos-Políticos-(Partidos-Públicos).pdf", type: "application/pdf", x_sendfile: true
  end
end
