import UnityEngine

class PositionPlayer (MonoBehaviour): 

	private player as GameObject
	private game_manager as GameObject
	private lastLevel as string
	private trueHero = false
	
	def Awake():
		self.player = self.transform.parent.Find("Player").gameObject
		self.game_manager = self.transform.parent.gameObject
		
		if GameObject.FindGameObjectWithTag("GameManager") and GameObject.FindGameObjectWithTag("GameManager").GetInstanceID() != self.game_manager.GetInstanceID():
			if not self.trueHero:
				Destroy(self.transform.parent.gameObject)
		self.trueHero = true
		self.lastLevel = Application.loadedLevelName

		player_positions = GameObject.Find("PlayerStartPosition")
		if player_positions:
			Destroy(player_positions)
		
	def OnLevelWasLoaded(level):
		
		if Application.loadedLevelName in ["Save", "Gift", "Teleport"] and self.lastLevel not in  ["Save", "Gift", "Teleport"]:
			change = (GameObject.Find("Change").GetComponent("ChangeScene") as ChangeScene)
			if change.scene == "":
			 	change.scene= self.lastLevel
			player_position = GameObject.Find("PlayerStartPosition")
			if player_position:
				self.player.transform.position = player_position.transform.position
				Destroy(player_position)
		else:
		
			player_positions = GameObject.Find("PlayerStartPosition")
			if player_positions:
				transf = player_positions.transform.FindChild(self.lastLevel)
				if transf:
					player_position = transf.gameObject
				
				if player_position:
					self.player.transform.position = player_position.transform.position
			
				Destroy(player_positions)
			
		
		self.lastLevel = Application.loadedLevelName
		
