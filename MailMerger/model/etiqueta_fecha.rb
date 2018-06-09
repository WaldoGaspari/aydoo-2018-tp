require_relative '../model/etiqueta_suma'

class Etiqueta_fecha

  def initialize
    @siguiente_funcion_etiqueta = Etiqueta_suma.new
  end

  def aplicar(cadena,json_entrada)
    cadena = aplicar_fechas(cadena)
    @siguiente_funcion_etiqueta.aplicar(cadena, json_entrada)
  end

  def aplicar_fechas(cadena)
    fecha = Date.today
    fecha_directa = fecha.day.to_s + "-" + fecha.month.to_s + "-" + fecha.year.to_s
    cadena = cadena.gsub("<date:d>", fecha_directa)
    fecha_inversa = fecha.year.to_s + "-" + fecha.month.to_s + "-" + fecha.day.to_s
    cadena = cadena.gsub("<date:i>", fecha_inversa)
    cadena
  end

end