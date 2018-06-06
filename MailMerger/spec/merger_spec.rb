require 'rspec'
require_relative '../model/merger'
require 'json'

describe 'enviar mails a traves de un JSON' do

  let(:merger) { Merger.new }

  json = {
      "template":"Hola <nombre>,\n\r Por medio del presente mail te estamos invitando a <nombre_evento>, que se desarrollará en <lugar_del_evento>, el día <fecha_del_evento>. Por favor confirmar su participación enviando un mail a <mail_de_confirmacion>.\n\rSin otro particular.La direccion",
      "contactos":[
          {
              "nombre":"juan",
              "apellido":"perez",
              "mail":"juanperez@test.com"
          },
          {
              "nombre":"maria",
              "apellido":"gonzalez",
              "mail":"mariagonzalez@test.com"
          }
      ],
      "datos":{
          "remitente": "universidad@untref.com",
          "asunto":"Invitación a fiesta de fin de año",
          "nombre_evento":"la cena de fin de año de la UNTREF",
          "lugar_del_evento":"el Centro de estudios (avenida Directorio 887, Caseros)",
          "fecha_del_evento":"5 de diciembre",
          "mail_de_confirmacion":"fiesta@untref.com"
      }
  }

  it 'al recibir un JSON y un mail no falla' do
    mail = Fake_envio_de_mails.new
    expect(merger.enviarMails(json,mail)).to be_truthy
  end

  it 'llenar plantilla devuelve el formulario lleno' do
    entregado = "Hola <nombre>, te estamos invitando a mi <nombre_evento>"
    datosEntregados = {
        "nombre": "nigga",
        "nombre_evento":"cumpleañito",
    }
    expect(merger.llenarPlantilla(entregado, datosEntregados)).to eq "Hola nigga, te estamos invitando a mi cumpleañito"
  end

  it 'al recibir un JSON y envia los mails' do
    mail = Fake_envio_de_mails.new
    expect(merger.enviarMails(json,mail)).to be_truthy
    expect(mail.mails_enviados[0]["remitente"]).to eq "universidad@untref.com"
    expect(mail.mails_enviados[0]["destinatario"]).to eq "juanperez@test.com"
    expect(mail.mails_enviados[0]["asunto"]).to eq "Invitación a fiesta de fin de año"
    expect(mail.mails_enviados[0]["cuerpo_del_mensaje"]).to eq "Hola juan,\n\r Por medio del presente mail te estamos invitando a la cena de fin de año de la UNTREF, que se desarrollará en el Centro de estudios (avenida Directorio 887, Caseros), el día 5 de diciembre. Por favor confirmar su participación enviando un mail a fiesta@untref.com.\n\rSin otro particular.La direccion"
    expect(mail.mails_enviados[1]["remitente"]).to eq "universidad@untref.com"
    expect(mail.mails_enviados[1]["destinatario"]).to eq "mariagonzalez@test.com"
    expect(mail.mails_enviados[1]["asunto"]).to eq "Invitación a fiesta de fin de año"
    expect(mail.mails_enviados[1]["cuerpo_del_mensaje"]).to eq "Hola maria,\n\r Por medio del presente mail te estamos invitando a la cena de fin de año de la UNTREF, que se desarrollará en el Centro de estudios (avenida Directorio 887, Caseros), el día 5 de diciembre. Por favor confirmar su participación enviando un mail a fiesta@untref.com.\n\rSin otro particular.La direccion"
  end

end


class Fake_envio_de_mails

  def initialize
    @mails_enviados = Array.new
    @cantidad_mails = 0
  end
  attr_accessor :mails_enviados, :cantidad_mails

  def enviar(remitente, destinatario, asunto, cuerpo_del_mensaje)
    @mails_enviados[@cantidad_mails] = Hash.new
    @mails_enviados[@cantidad_mails] = {"remitente"=>remitente, "destinatario"=>destinatario, "asunto"=>asunto, "cuerpo_del_mensaje"=>cuerpo_del_mensaje}
    @cantidad_mails += 1
  end

end