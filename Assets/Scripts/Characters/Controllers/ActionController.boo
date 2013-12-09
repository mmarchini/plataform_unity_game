import UnityEngine

class ActionController (MonoBehaviour): 

	def HasAction(action as string):
		_action as Action =  self.GetComponent("Action$(action)")
		if _action:
			return true
		return false

	def Execute(action as string):
		_action as Action =  self.GetComponent("Action$(action)")
		if _action:
			_action.StartAction()
		else:
			Debug.Log("Action $(action) does not exist.")
			
	def Executing(action as string):
		_action as Action =  self.GetComponent("Action$(action)")
		if _action:
			return _action.enabled
		else:
			Debug.Log("Action $(action) does not exist.")
		return false
			
