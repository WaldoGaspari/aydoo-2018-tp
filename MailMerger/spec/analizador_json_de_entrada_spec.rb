require 'rspec'
require 'json'
require_relative '../model/analizador_json_de_entrada'

describe 'analizar el JSON de entrada' do
	
	let(:analizador) { AnalizadorJsonDeEntrada.new }

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

    it 'al NO recibir una lista de contactos NO deberia enviar ningun mail y deberia lanzar una excepcion' do
      expect { expect { analizador.analizar_json_de_entrada(json_sin_contactos) }.to raise_error ArgumentError, 'No posee una lista de candidatos.'}
    end

    it 'al NO recibir los datos para enviar los mails deberia lanzar una excepcion' do
      expect { expect { analizador.analizar_json_de_entrada(json_sin_datos) }.to raise_error ArgumentError, 'No posee los datos para armar los mails.'}
    end

    it 'al NO recibir la plantilla para enviar los mails deberia lanzar una excepcion' do
      expect { expect { analizador.analizar_json_de_entrada(json_sin_template) }.to raise_error ArgumentError, 'No posee plantilla para armar los mails correspondientes.'}
    end

end