import UnityEngine

class HUDWindow(InterfaceWindow): 
	
	def Awake():
		self.x = 0
		self.y = 0
		self.width = 52
		self.height = 23
		for ie as string in ["HPBar", "MPBar", "SelectedOrbs", "CurrentSkill"]:
			new_ie = self.gameObject.AddComponent(ie)
			self._interface_elements.Add(new_ie)
		
	
