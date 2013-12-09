import UnityEngine

class ActionDeath (Action): 

	virtual def StartAction():
		for _action as Action in self.GetComponents(Action):
				_action.enabled = false
		self.enabled = true
		
	virtual def EndAction():
		if self.enabled:
			Destroy(self.gameObject)
