require_relative '../model/etiqueta_time'

class Etiqueta_empty

  def initialize
    @siguiente_funcion_etiqueta = Etiqueta_time.new
  end

  def aplicar(cadena,json_entrada)
    cadena = aplicar_empty(cadena,json_entrada)
    @siguiente_funcion_etiqueta.aplicar(cadena, json_entrada)
  end

  def aplicar_empty(cadena, json_entrada)
    if (cadena.include?  "<empty(")
      indice_empty = cadena.index('<empty(')
      campo_buscado = ""
      campo_por_reemplazar = ""
      indice_string = indice_empty + 7
      while cadena[indice_string] != ',' do
        campo_buscado = campo_buscado + cadena[indice_string]
        indice_string = indice_string + 1
      end
      indice_string = indice_string + 1
      while cadena[indice_string] != ')' do
        campo_por_reemplazar = campo_por_reemplazar + cadena[indice_string]
        indice_string = indice_string + 1
      end
      indice_string = indice_string + 1

      json = json_entrada.to_json
      json_parseado = JSON.parse(json)

      if json_parseado['datos'][campo_buscado].nil?
        campo_a_reemplazar = cadena[indice_empty..indice_string]
        cadena = cadena.gsub(campo_a_reemplazar, campo_por_reemplazar)
      end
    end
    cadena
  end

end