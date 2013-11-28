import UnityEngine

class Buff (MonoBehaviour): 

	public label as string
	public description as string
	public time = 4
	[HideInInspector]
	public current_time = -10
	protected destroy = false
	[HideInInspector]
	public affected_attributes = []
	
	effect as GameObject
	
	
	
	virtual def Effect(char_controller as GenericChar, caller as string) as single:
		return 0.0
	
	def Start():
		self.Reset()	
		
		a = Resources.Load("Effects/$(self.label)", GameObject) as GameObject
		if a:
			go as GameObject = Instantiate(a)
			go.transform.parent = self.gameObject.transform
			go.transform.localPosition = Vector3(0,0.2,0)
			go.transform.localScale = Vector3(0.4,0.4,0.4)
			self.effect = go

	
	def Update():
		if (self.current_time >= 0 and Time.time - self.current_time > time) or self.destroy:
			Destroy(self)
	
	virtual def Reset():
		self.current_time = Time.time
		destroy = false

	def OnDestroy():
		if self.effect:
			Destroy(self.effect)
