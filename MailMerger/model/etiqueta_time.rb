require_relative '../model/etiquetas'

class Etiqueta_time

  def aplicar (cadena, json_entrada)
    cadena = aplicar_time(cadena)
    cadena
  end

  def aplicar_time (cadena)
    if (cadena.include? "<time>")
      hora = Time.now
      hora_formato_24 = hora.hour.to_s + ":" + hora.min.to_s
      cadena = cadena.gsub('<time>', hora_formato_24)
    end
    cadena
  end
end