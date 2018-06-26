class DatosJsonDeEntradaException < StandardError

	def initialize
		raise "No posee los datos para armar los mails."
	end
end