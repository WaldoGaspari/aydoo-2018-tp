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
    @mensajeConDatos = self.llenarPlantilla(@mensajeConDatos,datos)

    etiquetas = Etiquetas.new

    destinatario.each do |destinatarioIterado|
      cuerpoMail = @mensajeConDatos
      cuerpoMail = self.llenarPlantilla(cuerpoMail,destinatarioIterado)
      cuerpoMail = etiquetas.aplicar_todas(cuerpoMail,json_parseado)
      @envio.enviar(datos['remitente'].to_s, destinatarioIterado['mail'].to_s, datos['asunto'].to_s, cuerpoMail)
      puts cuerpoMail
     end

  end

  def llenarPlantilla(cadena, json)
    cadena_devuelta = cadena
    json.each do |dato|
      reemplazar = "<" + dato[0].to_s + ">"
      cadena_devuelta = cadena_devuelta.gsub(reemplazar, dato[1].to_s)
    end
    cadena_devuelta
  end

end