require_relative '../model/json_entrada_exception'

class EtiquetaJsonDeEntradaException < JsonEntradaException

	def initialize (etiqueta_con_error)
		raise "La etiqueta: #{etiqueta_con_error} no pudo ser reemplazada (no existe como dato, contacto, ni es una etiqueta especial)."
	end
end