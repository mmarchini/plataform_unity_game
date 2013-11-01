import UnityEngine

class PassiveMenuPointsLeft(InterfaceElement): 
	
	text as string:
		get:
			return "$(self.player.Level - self.player.passivePoints)"
	
	def Awake():
		super.Awake()
		self.x = 62
		self.y = 16
		self.width = 6
		self.height = self.width*((Screen.width/Screen.height) cast single)
		self.FontSize = 4
		self.TextX = 1
		self.TextY= 3.5
		self.texture = Resources.Load("$(self.gui_path)/IconFrame") as Texture
		