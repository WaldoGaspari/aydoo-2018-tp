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
        puts "es nil! "
      end
    end
    cadena
  end

=begin
<date:i> : debe reemplazarse por la fecha actual en formato inverso: AAAA-MM-DD
<date:d>: debe reemplazarse por la fecha actual en formato: DD-MM-AAAA
<empty(pais,argentina)>: si el placeholder “pais” no está definido en el archivo de datos, entonces utilizar el valor “argentina”
<sum(monto1, monto2)>: debe reemplazarse por la suma de los placesholders monto1 y monto2
=end

end