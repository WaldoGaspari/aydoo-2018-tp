require_relative '../model/etiqueta_suma'

class EtiquetaFecha

  def aplicar(cadena,json_entrada)
    fecha_directa = Date.today.strftime("%d-%m-%Y")
    cadena = cadena.gsub("<date:d>", fecha_directa)
    fecha_inversa = Date.today.strftime("%Y-%m-%d")
    cadena = cadena.gsub("<date:i>", fecha_inversa)
    cadena
  end
  
end