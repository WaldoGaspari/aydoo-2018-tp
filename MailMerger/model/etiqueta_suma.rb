require_relative '../../MailMerger/model/etiqueta_empty'

class EtiquetaSuma

  def initialize
    @siguiente_funcion_etiqueta = EtiquetaEmpty.new
  end

  def aplicar(cadena,json_entrada)
    cadena = aplicar_suma(cadena)
    @siguiente_funcion_etiqueta.aplicar(cadena, json_entrada)
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

end