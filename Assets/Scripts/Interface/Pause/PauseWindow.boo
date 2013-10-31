import UnityEngine

class PauseWindow (InterfaceWindow): 

	protected player as Player
	
	possible as Hash = {}
	
	protected currentWindow as string = "Pause"

	def Awake():
		self.possible = {
			"Pause":self.gameObject.AddComponent("PauseMenu"),
			"Passive":self.gameObject.AddComponent("PassiveMenu"),
		}
		print(self.possible.ContainsKey("PauseMenu"))
		
		
		
		self.player = self.GetComponent("Player")
	
	interface_elements:
		get:
			if Input.GetButtonDown("Pause"):
				self.currentWindow = "Pause"
			elif Input.GetButtonDown("Attack") and self.currentWindow == "Pause":
				self.currentWindow = "Passive"
			elif Input.GetButtonDown("Skill") and self.currentWindow == "Passive":
				self.currentWindow = "Pause"
				
			return [self.possible[self.currentWindow]]
	
	DrawWindow:
		get:
			return self.player.paused
	
	def DrawInterfaceElements():
		super.DrawInterfaceElements()
		GUI.BringWindowToFront(self.WindowID)
		
	def Reset():
		self.WindowID = 1
		self.x = 15
		self.y = 0
		self.width = 75
		self.height = 95
		self.possible = {}