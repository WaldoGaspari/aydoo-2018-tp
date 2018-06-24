class PlantillaJsonDeEntradaException < StandardError

	def initialize
		raise "No posee plantilla para armar los mails correspondientes."
	end
end