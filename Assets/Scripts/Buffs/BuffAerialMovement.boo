import UnityEngine

class BuffAerialMovement (Buff): 

	def Awake():
		self.label = "Aerial Movement"
		self.affected_attributes = ["MovementSpeed", "Jump"]
	
	virtual def Effect(char_controller as GenericChar, caller as string) as single:
		return (char_controller.baseAttributes[caller] cast single)*1.15