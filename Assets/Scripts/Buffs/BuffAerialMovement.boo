import UnityEngine

class BuffAerialMovement (Buff): 

	def Awake():
		self.label = "Aerial Movement"
		self.affected_attributes = ["MovementSpeed", "Jump"]
		
	
	def Reset():
		super.Reset()
		self.MPSec = 5
	
	virtual def Effect(caller as string) as single:
		if char_controller:
			return (char_controller.baseAttributes[caller] cast single)*1.15