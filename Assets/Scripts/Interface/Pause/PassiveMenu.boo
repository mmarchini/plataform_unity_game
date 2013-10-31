import UnityEngine

class PassiveMenu (InterfaceElement): 
			
	def DrawInterfaceElement():
		passives = List(self.player.passive_controller.passives.Values)

