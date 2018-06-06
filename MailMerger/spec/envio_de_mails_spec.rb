require 'rspec'
require_relative '../model/envio_de_mails'
require_relative '../model/fake_envio_de_mails'
require 'json'

describe 'enviar mails' do

  let(:mail) { Fake_EnvioDeMails.new }



  it 'se envia un mail dando los parametros' do
    mail.enviar('remitente@test.com', 'destinatario@test.com', 'Prueba', 'Mensaje de prueba')

    expect(mail.mails_enviados[0]["remitente"]).to eq "remitente@test.com"
    expect(mail.mails_enviados[0]["destinatario"]).to eq "destinatario@test.com"
    expect(mail.mails_enviados[0]["asunto"]).to eq "Prueba"
    expect(mail.mails_enviados[0]["cuerpo_del_mensaje"]).to eq "Mensaje de prueba"
  end

  it 'se envian 2 mails dando los parametros' do
    mail.enviar('remitente@test.com', 'destinatario@test.com', 'Prueba', 'Mensaje de prueba')
    mail.enviar('carlos@test.com', 'mabel@test.com', 'test', 'hola')

    expect(mail.mails_enviados[0]["remitente"]).to eq "remitente@test.com"
    expect(mail.mails_enviados[0]["destinatario"]).to eq "destinatario@test.com"
    expect(mail.mails_enviados[0]["asunto"]).to eq "Prueba"
    expect(mail.mails_enviados[0]["cuerpo_del_mensaje"]).to eq "Mensaje de prueba"
    expect(mail.mails_enviados[1]["remitente"]).to eq "carlos@test.com"
    expect(mail.mails_enviados[1]["destinatario"]).to eq "mabel@test.com"
    expect(mail.mails_enviados[1]["asunto"]).to eq "test"
    expect(mail.mails_enviados[1]["cuerpo_del_mensaje"]).to eq "hola"
  end

end

