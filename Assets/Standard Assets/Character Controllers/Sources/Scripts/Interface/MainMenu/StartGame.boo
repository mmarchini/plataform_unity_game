import UnityEngine

class StartGame(MainMenuItem):
	itemText as string:
		get:
			return "Start Game"
			
	def Action():
		Application.LoadLevel("Test")
	
			
	
