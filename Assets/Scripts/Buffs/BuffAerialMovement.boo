import UnityEngine

class BuffAerialMovement (Buff): 

	def Awake():
		self.label = "Aerial Movement"
		self.affected_attributes = ["MovementSpeed", "Jump"]
	
#	def Start():
#		halo as RenderSettings = self.gameObject.AddComponent("RenderSettings")
#		halo.haloStrength = 1
		
	
	virtual def Effect(char_controller as GenericChar, caller as string) as single:
		return (char_controller.baseAttributes[caller] cast single)*1.15