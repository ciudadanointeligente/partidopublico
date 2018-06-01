class WelcomeController < ApplicationController
  def index
     @partidos = Partido.all

     render layout: "welcome"
  end

  def logo
	   render layout: "logo"
	end

  def etl
    @datos = EtlRun.pluck(:fecha_datos).uniq.sort.map{|d| {d => EtlRun.where(fecha_datos: d)}}
    @job_names = EtlRun.pluck(:job_name).uniq.sort
    @lines = []
    @datos.each do |d|
      # p d.keys.first
      values = d.values.first.pluck(:job_name)
      files = []
      logs = []
      counts = []
      results = []
      # p values
      @job_names.each do |j|
        counts << { j => values.count(j)}
        files << { j => EtlRun.file_exists?(d.keys.first, j)}
        logs << { j => EtlRun.log_file_exists?(d.keys.first, j) }
        results << { j => d.values.first.where(job_name: j)}
        # p results
      end
      @lines << { d.keys.first => {:counts => counts,:files => files,:logs => logs,:results => results } }
    end
    # p @lines
    render layout: "logo_2"
  end

end
