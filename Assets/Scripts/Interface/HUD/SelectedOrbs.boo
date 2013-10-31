import UnityEngine

class SelectedOrbs(InterfaceElement): 
	
	def Awake():
		super.Awake()
		self.x = 22
		self.y = 1
		self.width = 30
		self.height = 11
		self.FontSize = 5
		self.TextX = 2
		self.TextY= 1.55
		self.texture = Resources.Load("$(self.gui_path)/Label") as Texture

	private orbs_colors = {"Water":"blue", "Fire":"red", "Wind":"green"}
	
	text as string:
		get:
			orbs = player.SelOrbs
			selected_orbs = ""
			if orbs:
				for orb in orbs:
					selected_orbs = selected_orbs + "<color=$(orbs_colors[orb])> $(orb) </color>"
			return selected_orbs
