import UnityEngine

class StartGame(MainMenuItem):
	itemText as string:
		get:
			return "Start Game"

	def Awake():
		super.Awake()
		self.width = 26
		self.height = 10.6
		self.FontSize = 7
		self.x = 11.5
		self.y = 30
									
	def Action():
		Application.LoadLevel("Map1")
	
			
	
