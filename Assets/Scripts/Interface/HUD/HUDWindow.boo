import UnityEngine

class HUDWindow(InterfaceWindow): 
	
	def Awake():
		self.x = 0
		self.y = 0
		self.width = 100
		self.height = 100
		for ie as string in ["HPBar", "MPBar", "SelectedOrbs", "CurrentSkill", "Level"]:
			new_ie = self.gameObject.AddComponent(ie)
			self._interface_elements.Add(new_ie)
		
	
