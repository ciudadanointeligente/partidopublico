module PartidosHelper
  def not_null(object, attr)
    if object.nil?
      object = ''
    else
      object[attr]
    end
  end

  def get_month(month_number)
    meses = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
             'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
    meses[month_number-1]
  end

  def integer_or_zero(object)
    object.nil? ? 0 : object.to_i
  end
end
