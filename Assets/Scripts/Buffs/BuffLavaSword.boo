import UnityEngine

class BuffLavaSword (Buff): 

	def Awake():
		self.label = "Lava Sword"
		self.affected_attributes = ["ATK", "ATKRange"]

	def Reset():
		super.Reset()
		self.MPSec = 5
		
	virtual def Effect(caller as string) as single:
		return (char_controller.baseAttributes[caller] cast single)*1.5