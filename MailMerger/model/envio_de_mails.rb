require 'mail'
require_relative '../model/mail_server_unreachable_exception'

class EnvioDeMails

  def enviar(remitente, destinatario, asunto, cuerpo_del_mensaje)
    begin
      Mail.defaults do
        delivery_method :smtp, address: "localhost", port: 1025
      end

      Mail.deliver do
        from remitente
        to destinatario
        subject asunto
        body cuerpo_del_mensaje
      end
    
    rescue Errno::ECONNREFUSED
      raise MailServerUnreachableException.new
    end
  end

end