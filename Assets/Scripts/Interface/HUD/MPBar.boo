import UnityEngine


class MPBar (InterfaceElement): 

	def Awake():
		super.Awake()
		self.x = 1
		self.y = 12
		self.width = 22
		self.height = 11
		self.FontSize = 5
		self.TextX = 2
		self.TextY= 1.55
		self.texture = Resources.Load("$(self.gui_path)/Label") as Texture

	text as string:
		get:
			cur_MP as single = self.player.CurrentMP
			max_MP as single = self.player.GetCharAttribute("MP")
			percent = (cur_MP/max_MP)
			color = ""
			if percent > 0.5:
				color = "blue"
			elif 0.15 < percent:
				color = "yellow"
			else:
				color = "red"
				
			return "MP: <color=$(color)>$(cur_MP)</color> <color='white'> / $(max_MP)</color>"
