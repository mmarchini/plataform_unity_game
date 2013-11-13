import UnityEngine


class EnemyHP (InterfaceElement): 

	private char_controller as GenericChar

	def Awake():
		super.Awake()
		self.char_controller = self.GetComponent("GenericChar")
		self.x = 1
		self.y = 1
		self.width = 22
		self.height = 11
		self.FontSize = 5
		self.TextX = 2
		self.TextY= 1.55
		self.texture = Resources.Load("$(self.gui_path)/Label") as Texture
	
	def Update():
		a = self.char_controller.GetCharPosition()
		self.x = a.x
		self.y = a.y+1
	
	def OnGUI():
		self.DrawInterfaceElement()
	
	text as string:
		get:
			cur_HP as single = self.player.CurrentHP
			max_HP as single = self.player.GetCharAttribute("HP")
			percent = (cur_HP/max_HP)
			color = ""
			if percent > 0.5:
				color = "lime"
			elif 0.15 < percent:
				color = "yellow"
			else:
				color = "red"
			
			return "$(cur_HP)"
