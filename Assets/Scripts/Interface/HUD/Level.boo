import UnityEngine


class Level(InterfaceElement): 

	def Awake():
		super.Awake()
		self.x = 75
		self.y = 1
		self.width = 25
		self.height = 11
		self.FontSize = 5
		self.TextX = 2
		self.TextY= 1.55
		self.texture = Resources.Load("$(self.gui_path)/Label") as Texture
	
	text as string:
		get:
			percentEXP as int = (100*self.player.currentEXP/self.player.nextLevelEXP)
			return "Level: $(self.player.Level) ($(percentEXP)%)"
