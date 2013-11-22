import UnityEngine

class BuffHotSteam (Buff): 

	def Awake():
		self.label = "Hot Steam"
		self.affected_attributes = ["Block"]
	
	def Reset():
		super.Reset()
		self.current_time = -1
		
	virtual def Effect(char_controller as GenericChar, caller as string) as single:
		destroy = true
		return (char_controller.baseAttributes["HP"] cast single)
