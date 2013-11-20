import UnityEngine

class ActionDamaged (Action): 

	virtual def StartAction():
		for _action as Action in self.GetComponents(Action):
				_action.enabled = false
		if self.generic_char_controller and self.generic_char_controller.Jumping:
			self.char_speed = self.generic_char_controller.moveSpeed
		self.enabled = true
