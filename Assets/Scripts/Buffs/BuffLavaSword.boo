import UnityEngine

class BuffLavaSword (Buff): 

	def Awake():
		self.label = "Lava Sword"
		self.affected_attributes = ["ATK", "ATKRange"]
	
#	def Start():
#		halo as RenderSettings = self.gameObject.AddComponent("RenderSettings")
#		halo.haloStrength = 1
		
	
	virtual def Effect(char_controller as GenericChar) as single:
		return 5