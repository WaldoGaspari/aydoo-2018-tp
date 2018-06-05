require 'date'
require 'json'

class Etiquetas

  def aplicarFecha(cadena)
    fecha = Date.today
    fecha_directa = fecha.day.to_s + "-" + fecha.month.to_s + "-" + fecha.year.to_s
    cadena = cadena.gsub("<date:d>", fecha_directa)
    fecha_inversa = fecha.year.to_s + "-" + fecha.month.to_s + "-" + fecha.day.to_s
    cadena = cadena.gsub("<date:i>", fecha_inversa)

    cadena
  end


  def aplicarEmpty(cadena, jsonEntrada)
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


      json = jsonEntrada.to_json
      jsonParseado = JSON.parse(json)

      if jsonParseado['datos'][campo_buscado].nil?
        aReemplazar = cadena[indice_empty..indice_string]
        cadena = cadena.gsub(aReemplazar, campo_por_reemplazar)
      end
    end
    cadena
  end

  def aplicarSuma(cadena)
    if (cadena.include?  "<sum(")
      indiceSuma = cadena.index('<sum(')
      primerNro = ""
      segundoNro = ""
      indice = indiceSuma + 5
      while cadena[indice] != ',' do
        primerNro = primerNro + cadena[indice]
        indice = indice + 1
      end
      indice = indice + 1
      while cadena[indice] != ')' do
        segundoNro = segundoNro + cadena[indice]
        indice = indice + 1
      end
      indice = indice + 1

      suma = primerNro.to_i + segundoNro.to_i
      aReemplazar = cadena[indiceSuma..indice]
      cadena = cadena.gsub(aReemplazar, suma.to_s)
    end
    cadena
  end

  def aplicar_todas(cadena, json)
    cadena = self.aplicarFecha(cadena)
    cadena = self.aplicarEmpty(cadena,json)
    cadena = self.aplicarSuma(cadena)
    cadena
  end
  
end