import UnityEngine

class BuffLavaSword (Buff): 

	def Awake():
		self.label = "Lava Sword"
		self.affected_attributes = ["ATK", "ATKRange"]
	
	virtual def Effect(char_controller as GenericChar) as single:
		return 5