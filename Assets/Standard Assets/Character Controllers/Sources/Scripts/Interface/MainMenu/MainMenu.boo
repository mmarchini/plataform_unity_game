﻿import UnityEngine

class MainMenu(InterfaceElement): 
	
	SelectedMenu as string:
		get:
			return menuItems[0]
	private menuItems as List = ["StartGame", "About"]
	private menuItem as InterfaceElement
	
	def Update():
		if Input.GetButtonDown("Attack"):
			clickedItem as MainMenuItem = self.GetComponent(self.SelectedMenu)
			clickedItem.Action()
		elif Input.GetAxis("Vertical") > 0.2:
			self.menuItems = [self.menuItems[-1]]+self.menuItems[:-1]
		elif Input.GetAxis("Vertical") < -0.2:
			self.menuItems = self.menuItems[1:]+[self.menuItems[0]]
			
	
	