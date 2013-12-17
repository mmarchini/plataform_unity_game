import UnityEngine

class BuffSteamBarrier (Buff): 

	private activated = true
	private effect_scale as Vector3

	def Awake():
		self.label = "Steam Barrier"
		self.affected_attributes = ["Block"]
	
	def Start():
		super.Start()
		self.effect.transform.localPosition.z = -0.25
		self.effect_scale = self.effect.transform.localScale
	
	virtual def Effect(caller as string) as single:
		if self.activated:
			activated = false
			self.current_time = Time.time
			self.effect.transform.localScale = Vector3.zero
			return (char_controller.baseAttributes["HP"] cast single)

	def Update():
		if not self.activated and (Time.time - self.current_time > time):
			activated = true
			self.effect.transform.localScale = self.effect_scale
	