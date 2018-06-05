require 'mail'

class EnvioDeMails

  def enviar(remitente, destinatario, asunto, cuerpo_del_mensaje)
    Mail.defaults do
      delivery_method :smtp, address: "localhost", port: 1025
    end

    Mail.deliver do
      from remitente
      to destinatario
      subject asunto
      body cuerpo_del_mensaje
    end
  end

end