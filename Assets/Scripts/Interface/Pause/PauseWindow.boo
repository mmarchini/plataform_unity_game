import UnityEngine

class PauseWindow (InterfaceWindow): 

	protected player as Player
	
	possible as Hash = {}
	possibleList as List
	
	
	protected currentWindow as string = "Pause"

	def Awake():
		possibleList = ["Pause", "Passive"]
		
		self.player = self.GetComponent("Player")
	
	interface_elements:
		get:
			if not self.player.paused:
				return []
			if Input.GetButtonDown("Pause"):
				self.currentWindow = "Pause"
			elif Input.GetButtonDown("Attack") and self.currentWindow == "Pause":
				self.currentWindow = "Passive"
				Input.ResetInputAxes()
			elif Input.GetButtonDown("Skill") and self.currentWindow == "Passive":
				self.currentWindow = "Pause"
				
			return [self.possible[self.currentWindow]]
	
	DrawWindow:
		get:
			return self.player.paused
	
	def DrawInterfaceElements():
		super.DrawInterfaceElements()
		GUI.BringWindowToFront(self.WindowID)
		
	def Update():
		if Input.GetButtonDown("Pause"):
			if self.player .paused:
				for p in possibleList:
					Destroy(self.possible[p])
				self.possible = {}
			else:
				for p in possibleList:
					self.possible[p]=self.gameObject.AddComponent("$(p)Menu")
			self.player.paused = not self.player.paused
			Input.ResetInputAxes()
			Time.timeScale = Mathf.Abs(Mathf.Abs(Time.timeScale)-1)
	
	def Reset():
		self.WindowID = 1
		self.x = 15
		self.y = 0
		self.width = 75
		self.height = 95
		self.possible = {}