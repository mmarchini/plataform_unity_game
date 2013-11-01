import UnityEngine

class PassiveMenuDescription(InterfaceElement): 
	
	public passive_item as PassiveMenuItem
	
	passive:
		get:
			return self.passive_item.passive
	
	text as string:
		get:
			return "<color='black'>$(self.passive.description)</color>"
	
	def Awake():
		super.Awake()
		self.x = 38
		self.y = 31
		self.width = 31
		self.height = 40
		self.FontSize = 3.5
		self.TextX = 1
		self.TextY= 1.3
		self.texture = Resources.Load("$(self.gui_path)/TextBox") as Texture
