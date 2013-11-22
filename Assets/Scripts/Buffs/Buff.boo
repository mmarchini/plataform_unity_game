import UnityEngine

class Buff (MonoBehaviour): 

	public label as string
	public description as string
	public time = 4
	public current_time = -10
	protected destroy = false
	public affected_attributes = []
	
	virtual def Effect(char_controller as GenericChar, caller as string) as single:
		return 0.0
	
	def Start():
		self.Reset()	
	
	def Update():
		if (self.current_time >= 0 and Time.time - self.current_time > time) or self.destroy:
			Destroy(self)
	
	virtual def Reset():
		self.current_time = Time.time
		destroy = false

	