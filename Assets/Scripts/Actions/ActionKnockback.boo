import UnityEngine

class ActionKnockback (ActionDamaged): 

	public MoveSpeed as single = 10

	virtual def StartAction():
		super.StartAction()
		self.char_speed = -MoveSpeed
		self.move = true