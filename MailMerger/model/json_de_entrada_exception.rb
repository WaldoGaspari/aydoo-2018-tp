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
end
