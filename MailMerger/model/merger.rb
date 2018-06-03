class Merger

  def enviarMails(json)
    destinatario = json['contactos']
    datos = json['datos']

    @mensajeConDatos = json['template']
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
    Remitente: #{datos['remitente']} 
    Destinatario: #{destinatarioIterado['mail']}
    Asunto: #{datos['asunto']}

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
  end

end