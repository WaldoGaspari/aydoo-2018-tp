require 'sinatra'
require 'sinatra/json'
require 'json'
require 'net/smtp'

configure do
  set :bind, '0.0.0.0'
end

post '/' do
  json_parseado = JSON.parse(request.body.read)

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

    msgstr = <<END_OF_MESSAGE
    From: Your Name 
    To: #{destinatarioIterado['mail']}
    Subject: #{datos['asunto']}
    Date: Sat, 23 Jun 2001 16:26:43 +0900
    Message-Id: <unique.message.id.string@example.com>

    #{cuerpoMail}
END_OF_MESSAGE

    puts msgstr
  end

=begin
  Net::SMTP.start('your.smtp.server', 25) do |smtp|
    smtp.send_message mensaje,
                      'your@mail.address',
                      'his_address@example.com'
  end
=end
  json({ "Resultado": "OK",})
end

class Merger

end