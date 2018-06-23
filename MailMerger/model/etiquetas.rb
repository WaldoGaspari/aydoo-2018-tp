require 'date'
require 'json'
require_relative '../model/etiqueta_fecha'

class Etiquetas

  def initialize
    @siguiente_funcion_etiqueta = EtiquetaFecha.new
  end

  def aplicar(cadena, json_entrada)
    @siguiente_funcion_etiqueta.aplicar(cadena, json_entrada)
  end
  
end