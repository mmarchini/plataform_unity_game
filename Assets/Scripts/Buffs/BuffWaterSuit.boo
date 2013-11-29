import UnityEngine

class BuffWaterSuit (Buff): 

	def Awake():
		self.label = "Water Suit"
		self.affected_attributes = ["ManaShield"]
	
	def Reset():
		super.Reset()
		self.MPSec = 1
				
	virtual def Effect(caller as string) as single:
		return 0.5
