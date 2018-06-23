require 'json'

class JsonDeEntradaException

  def analizar_json_de_entrada(json_de_entrada)
    if (json_de_entrada['contactos'].nil?)
      raise ArgumentError.new('No posee una lista de contactos.')
    end

    if (json_de_entrada['datos'].nil?)
      raise ArgumentError.new('No posee los datos para armar los mails.')
    end

    if (json_de_entrada['template'].nil?)
      raise ArgumentError.new('No posee plantilla para armar los mails correspondientes.')
    end
  end

  def analizar_etiquetas_sin_llenar(cadena)
    expresion_etiqueta = (/<.*?>/)
    lista_etiquetas = cadena.scan(expresion_etiqueta)

    lista_etiquetas.each do |etiqueta_iterada|
      etiqueta_sin_mayor_menor = etiqueta_iterada[1,etiqueta_iterada.length - 2]
      raise ArgumentError.new("La etiqueta: #{etiqueta_sin_mayor_menor} no pudo ser reemplazada (no existe como dato, contacto, ni es una etiqueta especial)")
    end
  end
end
