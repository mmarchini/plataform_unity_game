import UnityEngine

class ActionFireBall (Action): 

	def StartAction():
		if not self.enabled:
			a = Resources.Load("Effects/Fire Ball", GameObject) as GameObject
			Debug.Log(":)")
			if a:
				Debug.Log(":D")
				go as GameObject = Instantiate(a)
				go.transform.position = self.gameObject.transform.position
				char_controller as GenericChar = self.GetComponent("GenericChar")
				go.transform.position = char_controller.GetCharPosition()
				ball as GenericBall = go.GetComponent("GenericBall")
				ball.direction = char_controller.moveDirection
				go.transform.forward = -ball.direction
				ball.char_controller = char_controller
				ball.damage = char_controller.DMG*0.75
				ball.invokedBy = self.tag
		super.StartAction()
		

