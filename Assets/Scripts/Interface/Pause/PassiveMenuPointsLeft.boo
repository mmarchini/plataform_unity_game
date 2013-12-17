import UnityEngine

class PassiveMenuPointsLeft(InterfaceElement): 
	
	text as string:
		get:
			return "$(self.player.Level - self.player.passivePoints)"
	
	def Awake():
		super.Awake()
		self.x = 61
		self.y = 18
		self.width = 8
		self.height = 10
		self.FontSize = 7
		self.TextX = 1
		self.TextY= 2.5
		self.texture = Resources.Load("$(self.gui_path)/IconFrame") as Texture
		