require 'rspec'
require_relative '../model/merger'
require_relative '../model/fake_envio_de_mails'
require 'json'

describe 'enviar mails a traves de un JSON' do

  let(:merger) { Merger.new }
  let(:mail) { FakeEnvioDeMails.new }
  let(:analizador) { JsonDeEntradaException.new }

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

  json_sin_contactos = {
      "template":"Hola <nombre>,\n\r Por medio del presente mail te estamos invitando a <nombre_evento>, que se desarrollará en <lugar_del_evento>, el día <fecha_del_evento>. Por favor confirmar su participación enviando un mail a <mail_de_confirmacion>.\n\rSin otro particular.La direccion",
      "datos":{
          "remitente": "universidad@untref.com",
          "asunto":"Invitación a fiesta de fin de año",
          "nombre_evento":"la cena de fin de año de la UNTREF",
          "lugar_evento":"el Centro de estudios (avenida Directorio 887, Caseros)",
          "fecha_del_evento":"5 de diciembre",
          "Mail_de_confirmacion":"fiesta@untref.com"
      }
  }

  json_sin_datos = {
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
      ]
  }

  json_sin_template = {
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

  it 'al NO recibir una lista de contactos NO deberia enviar ningun mail y deberia lanzar una excepcion' do
    expect { expect { analizador.analizar_json_de_entrada(json_sin_contactos) }.to raise_error ArgumentError, 'No posee una lista de candidatos.'}
  end

  it 'al NO recibir los datos para enviar los mails deberia lanzar una excepcion' do
    expect { expect { analizador.analizar_json_de_entrada(json_sin_datos) }.to raise_error ArgumentError, 'No posee los datos para armar los mails.'}
  end

  it 'al NO recibir la plantilla para enviar los mails deberia lanzar una excepcion' do
    expect { expect { analizador.analizar_json_de_entrada(json_sin_template) }.to raise_error ArgumentError, 'No posee plantilla para armar los mails correspondientes.'}
  end

  it 'se llama al metodo enviar del mail' do
    mandador_mail = double(EnvioDeMails.new)
    expect(mandador_mail).to receive(:enviar)
    expect(mandador_mail).to receive(:enviar)
    expect(merger.enviar_mails(json, mandador_mail)).to be_truthy
  end

  it 'deberia lanzar una excepcion cuando hay una etiqueta que no se pudo reemplazar' do
    json_con_etiquetas_de_mas = {
        "template":"<saludo> <nombre>,\n\r Por medio del presente mail te estamos invitando a <nombre_evento>, que se desarrollará en <lugar_del_evento>",
        "contactos":[
            {
            "nombre":"juan",
        "apellido":"perez",
        "mail":"juanperez@test.com"
    }
    ],
        "datos":{
        "remitente": "universidad@untref.com",
        "asunto":"Invitación a fiesta de fin de año",
        "nombre_evento":"la cena de fin de año de la UNTREF",
        "lugar_del_evento":"el Centro de estudios (avenida Directorio 887, Caseros)",
    }
    }

    mandador_mail = double(EnvioDeMails.new)
    expect{merger.enviar_mails(json_con_etiquetas_de_mas,mandador_mail)}.to  raise_error ArgumentError, 'La etiqueta: saludo no pudo ser reemplazada (no existe como dato, contacto, ni es una etiqueta especial)'
  end
end