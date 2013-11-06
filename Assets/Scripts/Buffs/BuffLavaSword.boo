import UnityEngine

class BuffLavaSword (Buff): 

	def Awake():
		self.label = "Lava Sword"
	
	virtual def Effect() as single:
		return 0.0