require 'date'
require 'json'

class Etiquetas

  def aplicarFecha(cadena)
    fecha = Date.today
    fechaDirecta = fecha.day.to_s + "-" + fecha.month.to_s + "-" + fecha.year.to_s
    cadena = cadena.gsub("<date:d>", fechaDirecta)
    fechaInversa = fecha.year.to_s + "-" + fecha.month.to_s + "-" + fecha.day.to_s
    cadena = cadena.gsub("<date:i>", fechaInversa)

    cadena
  end


  def aplicarEmpty(cadena, jsonEntrada)
    if (cadena.include?  "<empty(")
      indiceEmpty = cadena.index('<empty(')
      campoBuscado = ""
      campoPorReemplazar = ""
      indiceString = indiceEmpty + 7
      while cadena[indiceString] != ',' do
        campoBuscado = campoBuscado + cadena[indiceString]
        indiceString = indiceString + 1
      end
      indiceString = indiceString + 1
      while cadena[indiceString] != ')' do
        campoPorReemplazar = campoPorReemplazar + cadena[indiceString]
        indiceString = indiceString + 1
      end
      indiceString = indiceString + 1


      json = jsonEntrada.to_json
      jsonParseado = JSON.parse(json)

      if jsonParseado['datos'][campoBuscado].nil?
        aReemplazar = cadena[indiceEmpty..indiceString]
        cadena = cadena.gsub(aReemplazar, campoPorReemplazar)
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