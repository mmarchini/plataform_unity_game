import UnityEngine

class PauseMenu(InterfaceElement): 
	
	DrawBox:
		get:
			return self.player.paused
	
	text as string:
		get:
			return ":D"
	
	def Update():
		if Input.GetButtonDown("Pause"):
			self.player.paused = not self.player.paused
			Time.timeScale = Mathf.Abs(Mathf.Abs(Time.timeScale)-1)

