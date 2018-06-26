require 'json'
require_relative '../model/contactos_json_de_entrada_exception'
require_relative '../model/datos_json_de_entrada_exception'
require_relative '../model/plantilla_json_de_entrada_exception'
require_relative '../model/etiqueta_json_de_entrada_exception'

class AnalizadorJsonDeEntrada

  def analizar_json_de_entrada(json_de_entrada)
    if (json_de_entrada['contactos'].nil?)
      puts "entra if (json_de_entrada['contactos'].nil?)"
      ContactosJsonDeEntradaException.new
    end

    if (json_de_entrada['datos'].nil?)
      DatosJsonDeEntradaException.new
    end

    if (json_de_entrada['template'].nil?)
      PlantillaJsonDeEntradaException.new
    end
  end

  def analizar_etiquetas_sin_llenar(cadena)
    expresion_etiqueta = (/<.*?>/)
    lista_etiquetas = cadena.scan(expresion_etiqueta)

    lista_etiquetas.each do |etiqueta_iterada|
      etiqueta_sin_mayor_menor = etiqueta_iterada[1,etiqueta_iterada.length - 2]
      EtiquetaJsonDeEntradaException.new(etiqueta_sin_mayor_menor)
    end
  end
end
