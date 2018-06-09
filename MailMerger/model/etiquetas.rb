require 'date'
require 'json'

class Etiquetas

  def aplicar_fecha(cadena)
    fecha = Date.today
    fecha_directa = fecha.day.to_s + "-" + fecha.month.to_s + "-" + fecha.year.to_s
    cadena = cadena.gsub("<date:d>", fecha_directa)
    fecha_inversa = fecha.year.to_s + "-" + fecha.month.to_s + "-" + fecha.day.to_s
    cadena = cadena.gsub("<date:i>", fecha_inversa)

    cadena
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

  def aplicar_suma(cadena)
    if (cadena.include?  "<sum(")
      indice_suma = cadena.index('<sum(')
      primer_numero = ""
      segundo_numero = ""
      indice = indice_suma + 5
      while cadena[indice] != ',' do
        primer_numero = primer_numero + cadena[indice]
        indice = indice + 1
      end
      indice = indice + 1
      while cadena[indice] != ')' do
        segundo_numero = segundo_numero + cadena[indice]
        indice = indice + 1
      end
      indice = indice + 1

      suma = primer_numero.to_i + segundo_numero.to_i
      campo_a_reemplazar = cadena[indice_suma..indice]
      cadena = cadena.gsub(campo_a_reemplazar, suma.to_s)
    end
    cadena
  end

  def aplicar_todas(cadena, json)
    cadena = self.aplicar_fecha(cadena)
    cadena = self.aplicar_empty(cadena, json)
    cadena = self.aplicar_suma(cadena)
    cadena
  end
  
end