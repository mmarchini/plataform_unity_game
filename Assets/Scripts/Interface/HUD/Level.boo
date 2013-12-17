import UnityEngine


class Level(InterfaceElement): 

	def Awake():
		super.Awake()
		self.x = 80
		self.y = 1
		self.width = 19
		self.height = 6
		self.FontSize = 4
		self.TextX = 2
		self.TextY= 1
		self.texture = Resources.Load("$(self.gui_path)/Label") as Texture
	
	text as string:
		get:
			percentEXP as int = (100*self.player.currentEXP/self.player.nextLevelEXP)
			return "Level: $(self.player.Level) ($(percentEXP)%)"
