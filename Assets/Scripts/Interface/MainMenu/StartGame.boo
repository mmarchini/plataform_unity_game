import UnityEngine

class StartGame(MainMenuItem):
	itemText as string:
		get:
			return "Start Game"

	def Awake():
		super.Awake()
		self.x = 15
		self.y = 30
									
	def Action():
		Application.LoadLevel("Map1")
	
			
	
