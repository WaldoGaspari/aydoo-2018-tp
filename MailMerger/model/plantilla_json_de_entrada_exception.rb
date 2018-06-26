class PlantillaJsonDeEntradaException < StandardError

	def initialize
		@mensaje = "No posee plantilla para armar los mails correspondientes."
		raise @mensaje
	end
end