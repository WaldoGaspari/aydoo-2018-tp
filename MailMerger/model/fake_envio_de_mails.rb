class Fake_EnvioDeMails < EnvioDeMails


    def initialize
      @mails_enviados = Array.new
      @cantidad_de_mails = 0
    end
    attr_accessor :mails_enviados, :cantidad_de_mails

    def enviar(remitente, destinatario, asunto, cuerpo_del_mensaje)
      @mails_enviados[@cantidad_de_mails] = Hash.new
      @mails_enviados[@cantidad_de_mails] = {"remitente"=>remitente, "destinatario"=>destinatario, "asunto"=>asunto, "cuerpo_del_mensaje"=>cuerpo_del_mensaje}
      @cantidad_de_mails += 1
    end

end