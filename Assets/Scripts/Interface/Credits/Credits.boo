import UnityEngine

class Credits(InterfaceWindow): 
	
	private lastTime as double = -10
	public changeItemTime as double = 0.25
	
	SelectedMenu as MainMenuItem:
		get:
			return self._interface_elements[0]

	def Awake():
		self.WindowID = 0
		self.x = 15
		self.y = 10
		self.width = 100
		self.height = 75
		new_ie = self.gameObject.AddComponent(Application.loadedLevelName)
		self._interface_elements.Add(new_ie)
	
	def Start():
		Destroy(GameObject.Find('GameManager'))
	
	def Update():
		if Input.GetButtonDown("Attack"):
			clickedItem as MainMenuItem = self.SelectedMenu
			clickedItem.Action()
		
		if Time.time - self.lastTime >= self.changeItemTime:
			if Input.GetAxis("Vertical") > 0.2:
				self._interface_elements = [self._interface_elements[-1]]+self._interface_elements[:-1]
				self.lastTime = Time.time
			elif Input.GetAxis("Vertical") < -0.2:
				self._interface_elements = self._interface_elements[1:]+[self._interface_elements[0]]
				self.lastTime = Time.time
			
	
	