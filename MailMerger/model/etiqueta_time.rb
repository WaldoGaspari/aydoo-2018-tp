require_relative '../model/etiquetas'

class EtiquetaTime

  def aplicar(cadena, json_entrada)
    if (cadena.include? "<time>")
      hora = Time.now.strftime("%H:%M")
      cadena = cadena.gsub('<time>', hora)
    end

    if (cadena.include? "<time:12>")
      hora = Time.now.strftime("%l:%M")
      cadena = cadena.gsub('<time:12>', hora + " pm")
    end
    cadena
  end
end