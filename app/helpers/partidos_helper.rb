module PartidosHelper
  def not_null(object, attr)
    if object.nil?
      object = ''
    else
      object[attr]
    end
  end
end
