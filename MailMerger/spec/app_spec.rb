require_relative '../../MailMerger/app'
require 'rspec'
require 'rack/test'
require 'json'

describe 'Tests app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
  json_entrada = {
      "template":"----------------------------------------------------------------Hola <nombre>,\n\r Por medio del presente mail te estamos invitando a <nombre_evento>, que se desarrollará en <lugar_del_evento>, el día <fecha_del_evento>. Por favor confirmar su participación enviando un mail a <mail_de_confirmacion>.\n\rSin otro particular.La direccion",
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
  json_incorrecto = {
      "template":"algo",
      "datos":{
          "asunto":"InvitaciÃ³n a fiesta de fin de aÃ±o",
      "nombre_evento":"la cena de fin de aÃ±o de la UNTREF",
      "lugar_evento":"el Centro de estudios (avenida Directorio 887, Caseros)",
      "fecha_del_evento":"5 de diciembre",
      "Mail_de_confirmacion":"fiesta@untref.com"
  }
  }

  json_etiquetas_demas = {
    "template":"<saludo> <nombre>,\n\r Por medio del presente mail te estamos invitando a <nombre_evento>, que se desarrollará en <lugar_del_evento>",
    "contactos":[
       {
          "nombre":"juan",
          "apellido":"perez",
          "mail":"aydoo@mailinator.com"
       }
    ],
    "datos":{
       "remitente": "universidad@untref.com",
       "asunto":"Ejemplo 10: tag usado dos veces"
    }
  }
  it 'deberia devolver una respuesta ok' do
    EnvioDeMails.any_instance.stub(:enviar)
    jso = json_entrada.to_json
    post '/', jso , "Content-Type" => "application/json"

    expect(last_response).to be_ok
  end

  it 'deberia devolver ok' do
    EnvioDeMails.any_instance.stub(:enviar)
    jso = json_entrada.to_json
    post '/', jso , "Content-Type" => "application/json"

    cuerpo_parseado = JSON.parse(last_response.body)

    expect(cuerpo_parseado['resultado']).to eq "ok"
    expect(last_response.status).to eq(200)
  end

  it 'deberia devolver error, entrada incorrecta' do
    EnvioDeMails.any_instance.stub(:enviar)
    jso = json_incorrecto.to_json
    post '/', jso , "Content-Type" => "application/json"
    cuerpo_parseado = JSON.parse(last_response.body)
    expect(cuerpo_parseado['resultado']).to eq "error, entrada incorrecta"
    expect(last_response.status).to eq(500)
  end

  it 'al usar un json de entrada con una etiqueta demas deberia devolver error, etiquetas incompletas' do
    EnvioDeMails.any_instance.stub(:enviar)
    jso = json_etiquetas_demas.to_json
    post '/', jso , "Content-Type" => "application/json"

    cuerpo_parseado = JSON.parse(last_response.body)

    expect(cuerpo_parseado['resultado']).to eq "error, etiquetas incompletas"
    expect(last_response.status).to eq(500)
  end

end