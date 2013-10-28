import UnityEngine

class MainMenuItem (InterfaceElement): 

	virtual itemText as string:
		get:
			return ""

	virtual def Action():
		pass

	text as string:
		get:
			main_menu as MainMenu = self.GetComponent("MainMenu")
			if main_menu.SelectedMenu == self.GetType().Name:
				return "<color='yellow'>$(itemText)</color>"
			return itemText
	