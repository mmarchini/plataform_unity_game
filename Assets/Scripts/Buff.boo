import UnityEngine

class Buff (MonoBehaviour): 

	public label as string
	public description as string
	public time = 10
	private current_time = -1
	public affected_attributes = []
	
	virtual def Effect(char_controller as GenericChar) as single:
		return 0.0
	
	def Start():
		self.Reset()	
	
	def Update():
		if Time.time - current_time > time:
			Destroy(self)
	
	virtual def Reset():
		self.current_time = Time.time
		
	