require 'rspec'
require_relative '../model/merger'
require_relative '../model/fake_envio_de_mails'
require 'json'

describe 'enviar mails a traves de un JSON' do

  let(:merger) { Merger.new }
  let(:mail) { Fake_EnvioDeMails.new }

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
    expect(merger.enviar_mails(json, mail)).to be_truthy
  end

  it 'llenar plantilla devuelve el formulario lleno' do
    entregado = "Hola <nombre>, te estamos invitando a mi <nombre_evento>"
    datosEntregados = {
        "nombre": "Lucas",
        "nombre_evento":"cumpleaños",
    }
    expect(merger.llenar_plantilla(entregado, datosEntregados)).to eq "Hola Lucas, te estamos invitando a mi cumpleaños"
  end

  it 'al recibir un JSON envia los mails' do
    expect(merger.enviar_mails(json, mail)).to be_truthy
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