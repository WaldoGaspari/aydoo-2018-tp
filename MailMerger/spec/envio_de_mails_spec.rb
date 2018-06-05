require 'rspec'
require_relative '../model/envio_de_mails'
require 'json'

describe 'enviar mails' do

  let(:envio) { EnvioDeMails.new }

  it 'se envia un mail dando los parametros' do
    expect(envio.enviar('remitente@test.com', 'destinatario@test.com', 'Prueba', 'Mensaje de prueba').to be_truthy)
  end

end