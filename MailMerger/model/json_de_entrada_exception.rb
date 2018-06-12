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

    #self.validar_existencia_etiquetas(json_de_entrada)

  end
end

def validar_existencia_etiquetas(json_de_entrada)
  expresion_etiqueta = (/<.*?>/)
  lista_etiquetas = json_de_entrada['template'].scan(expresion_etiqueta)

  lista_etiquetas.each do |etiqueta_iterada|
    etiqueta_sin_mayor_menor = etiqueta_iterada[1,etiqueta_iterada.length-2]
    if (json['datos'][etiqueta_sin_mayor_menor].nil?) and (json['contactos'][etiqueta_sin_mayor_menor].nil?)
      raise ArgumentError.new('existen etiquetas no definidas en datos y/o contactos')
    end
  end
end
