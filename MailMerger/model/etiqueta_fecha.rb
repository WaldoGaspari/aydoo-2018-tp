require_relative '../model/etiqueta_suma'

class EtiquetaFecha

  def initialize
    @siguiente_funcion_etiqueta = EtiquetaSuma.new
  end

  def aplicar(cadena,json_entrada)
    cadena = aplicar_fechas(cadena)
    @siguiente_funcion_etiqueta.aplicar(cadena, json_entrada)
  end

  def aplicar_fechas(cadena)
    fecha_directa = Date.today.strftime("%d-%m-%Y")
    cadena = cadena.gsub("<date:d>", fecha_directa)
    fecha_inversa = Date.today.strftime("%Y-%m-%d")
    cadena = cadena.gsub("<date:i>", fecha_inversa)
    cadena
  end
end