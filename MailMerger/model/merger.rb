require 'json'
require_relative '../model/envio_de_mails'

class Merger

  def initialize
    @envio = EnvioDeMails.new
  end

  def enviarMails(json)
    json_a_usar = json.to_json
    json_parseado = JSON.parse(json_a_usar)
    destinatario = json_parseado['contactos']
    datos = json_parseado['datos']

    @mensajeConDatos = json_parseado['template']
    datos.each do |dato|
      reemplazar = "<" + dato[0].to_s + ">"
      @mensajeConDatos = @mensajeConDatos.gsub(reemplazar, dato[1].to_s)
    end

    destinatario.each do |destinatarioIterado|
      cuerpoMail = @mensajeConDatos
      destinatarioIterado.each do |datosDestinatario|
        reemplazar = "<" + datosDestinatario[0].to_s + ">"
        cuerpoMail = cuerpoMail.gsub(reemplazar, datosDestinatario[1].to_s)
      end
      @envio.enviar(datos['remitente'].to_s, destinatarioIterado['mail'].to_s, datos['asunto'].to_s, cuerpoMail)
     end

  end

end