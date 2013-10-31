import UnityEngine
class MainMenuItem (InterfaceElement): 

	def Awake():
		super.Awake()
		self.width = 20
		self.height = 12
		self.FontSize = 6
		self.TextX = 1
		self.TextY= 1.3
		self.texture = Resources.Load("$(self.gui_path)/Label") as Texture


	virtual itemText as string:
		get:
			return ""

	virtual def Action():
		pass

	text as string:
		get:
			main_menu as MainMenu = self.GetComponent("MainMenu")
			if main_menu.SelectedMenu == self:
				return "<color='yellow'>$(itemText)</color>"
			return itemText
	