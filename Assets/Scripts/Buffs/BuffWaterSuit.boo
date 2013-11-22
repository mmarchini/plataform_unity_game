import UnityEngine

class BuffWaterSuit (Buff): 

	def Awake():
		self.label = "Water Suit"
		self.affected_attributes = ["ManaShield"]
	
	def Reset():
		super.Reset()
		self.time = 15
		
	virtual def Effect(char_controller as GenericChar, caller as string) as single:
		return 0.5
