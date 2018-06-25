require 'date'
require 'json'
require_relative '../model/etiqueta_fecha'
require_relative '../model/etiqueta_empty'
require_relative '../model/etiqueta_suma'
require_relative '../model/etiqueta_time'


class Etiquetas

  def initialize
  	@todas_las_etiquetas = [EtiquetaFecha.new, EtiquetaEmpty.new, EtiquetaSuma.new, EtiquetaTime.new]
  end

  def aplicar(cadena, json_entrada)
    cadena_modificada = cadena	
    i = 0
    for i in 0..(@todas_las_etiquetas.size - 1) do	
    	cadena_modificada = @todas_las_etiquetas[i].aplicar(cadena_modificada, json_entrada)
    	i == i + 1 
    end	
    cadena_modificada
  end
  
end