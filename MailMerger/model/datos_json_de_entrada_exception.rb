require_relative '../model/json_entrada_exception'

class DatosJsonDeEntradaException < JsonEntradaException

	def initialize
		raise "No posee los datos para armar los mails."
	end
end