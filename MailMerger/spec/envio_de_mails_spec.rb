require 'rspec'
require_relative '../model/envio_de_mails'
require_relative '../spec/fake_envio_de_mails'
require 'json'

describe 'enviar mails' do

  let(:mandador_mail) { double(EnvioDeMails.new) }

  it 'se envian 2 mails dando los parametros' do
    expect(mandador_mail).to receive(:enviar).with('remitente@test.com', 'destinatario@test.com', 'Prueba', 'Mensaje de prueba')
    expect(mandador_mail).to receive(:enviar).with('carlos@test.com', 'mabel@test.com', 'test', 'hola')

    mandador_mail.enviar('remitente@test.com', 'destinatario@test.com', 'Prueba', 'Mensaje de prueba')
    mandador_mail.enviar('carlos@test.com', 'mabel@test.com', 'test', 'hola')
  end

  it 'se manda mail dando los parametros' do
    expect(mandador_mail).to receive(:enviar).with('remitente@test.com', 'destinatario@test.com', 'Prueba', 'Mensaje de prueba')

    mandador_mail.enviar('remitente@test.com', 'destinatario@test.com', 'Prueba', 'Mensaje de prueba')
  end

end

