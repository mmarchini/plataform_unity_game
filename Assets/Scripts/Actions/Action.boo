import UnityEngine

class Action (MonoBehaviour): 
	
	public label as string
	
	protected generic_char_controller as GenericCharController
	
	[HideInInspector]
	public char_direction as Vector3
	[HideInInspector]
	public char_speed as single
	[HideInInspector]
	public move = false
	
	public _animation as AnimationClip
	public animationSpeed = 1f
	
	def Start():
		pass
		
	def Awake():
		_event = AnimationEvent()
		_event.functionName = "EndAction"
		_event.time = self._animation.length-0.1f
		self._animation.AddEvent(_event)
		self.generic_char_controller = self.GetComponent("GenericCharController")
		
	virtual def StartAction():
		for _action as Action in self.GetComponents(Action):
				if _action.enabled:
					return false
		if self.generic_char_controller and self.generic_char_controller.Jumping:
			self.char_speed = self.generic_char_controller.moveSpeed
		self.enabled = true
		
		return true
	
	virtual def EndAction():
		self.enabled = false
	