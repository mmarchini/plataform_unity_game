import UnityEngine

class PassiveMenuItem(InterfaceElement): 
	
	public passive as Passive
	
	description as PassiveMenuDescription
	
	private position = -2
	
	DrawBox:
		get:
			return self.player.paused
	
	text as string:
		get:
			return "<color='"+(self.position==0 and "yellow" or "white")+"'>$(self.passive.label)</color>"
	
	Y:
		get:
			return super.Y + self.position*(self.H*1.3)
	
	def DrawItem(position as int):
		self.position = position
		if self.position == 0:
			self.description.DrawInterfaceElement()
		self.DrawInterfaceElement()
	
	def LevelUp():
		Debug.Log("Clicou: $(self.passive.label)")
	
	def Awake():
		super.Awake()
		self.x = 7
		self.y = 45
		self.width = 29
		self.height = 12
		self.FontSize = 4
		self.TextX = 1
		self.TextY= 1.3
		self.texture = Resources.Load("$(self.gui_path)/Label") as Texture
		
		self.description = self.gameObject.AddComponent("PassiveMenuDescription")
		self.description.passive_item = self
