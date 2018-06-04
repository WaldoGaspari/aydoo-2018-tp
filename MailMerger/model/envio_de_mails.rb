require 'mail'

class EnvioDeMails

  def enviar
    Mail.defaults do
      delivery_method :smtp, address: "localhost", port: 1025
    end

    Mail.deliver do
      from 'remitente@test.com'
      to 'destinatario@test.com'
      subject 'Prueba'
      body "Mensaje de prueba"
    end
  end

end