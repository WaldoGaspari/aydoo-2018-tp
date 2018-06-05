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

  it 'al recibir un JSON deberia mandar los mails a todos los contactos seleccionados' do
    expect(merger.enviarMails(json)).to be_truthy
  end

  it 'llenar plantilla devuelve el formulario lleno' do
    entregado = "Hola <nombre>, te estamos invitando a mi <nombre_evento>"
    datosEntregados = {
        "nombre": "nigga",
        "nombre_evento":"cumpleañito",
    }
    expect(merger.llenarPlantilla(entregado, datosEntregados)).to eq "Hola nigga, te estamos invitando a mi cumpleañito"
  end

end