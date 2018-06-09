require 'json'
require_relative '../model/envio_de_mails'

class Merger

  def enviar_mails(json, enviador_de_mails)
    json_a_usar = json.to_json
    json_parseado = JSON.parse(json_a_usar)
    destinatario = json_parseado['contactos']
    datos = json_parseado['datos']

    @mensaje_con_datos = json_parseado['template']
    @mensaje_con_datos = self.llenar_plantilla(@mensaje_con_datos, datos)

    etiquetas = Etiquetas.new

    destinatario.each do |destinatario_iterado|
      cuerpo_mail = @mensaje_con_datos
      cuerpo_mail = self.llenar_plantilla(cuerpo_mail, destinatario_iterado)
      cuerpo_mail = etiquetas.aplicar_todas(cuerpo_mail,json_parseado)
      enviador_de_mails.enviar(datos['remitente'].to_s, destinatario_iterado['mail'].to_s, datos['asunto'].to_s, cuerpo_mail)
     end

  end

  def llenar_plantilla(cadena, json)
    cadena_devuelta = cadena
    json.each do |dato|
      reemplazar = "<" + dato[0].to_s + ">"
      cadena_devuelta = cadena_devuelta.gsub(reemplazar, dato[1].to_s)
    end
    cadena_devuelta
  end

end