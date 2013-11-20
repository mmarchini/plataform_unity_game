import UnityEngine

class Action (MonoBehaviour): 
	
	public label as string
	
	public char_direction as Vector3
	public char_speed as single
	
	public _animation as AnimationClip
	
	def Start():
		_event = AnimationEvent()
		_event.functionName = "EndAction"
		_event.time = self._animation.length-0.1f
		self._animation.AddEvent(_event)
	
	def EndAction():
		self.gameObject.Destroy(self)
	