import UnityEngine

class StartGame(InterfaceElement):
	
	text as string:
		get:
			main_menu as MainMenu = self.GetComponent("MainMenu")
			_text = "Start Game"
			if main_menu.SelectedMenu == self.GetType().Name:
				_text = "<color='yellow'>$(_text)</color>"
			return _text
			
	
