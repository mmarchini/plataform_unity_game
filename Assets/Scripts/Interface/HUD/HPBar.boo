import UnityEngine


class HPBar (InterfaceElement): 

	def Awake():
		super.Awake()
		self.x = 1
		self.y = 1
		self.width = 22
		self.height = 6
		self.FontSize = 4
		self.TextX = 2
		self.TextY= 1
		self.texture = Resources.Load("$(self.gui_path)/Label") as Texture
	
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
			
			return "HP: <color=$(color)>$(cur_HP)</color> <color='white'> / $(max_HP)</color>"
