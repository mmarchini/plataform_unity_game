import UnityEngine

class InterfaceWindow (MonoBehaviour): 

	public WindowID as int = 0

	public x as single = 10.0f
	public y as single = 10.0f
	public width as single = 10.0f
	public height as single = 10.0f
	
	public texture as Texture2D
	
	private _style as GUIStyle

	protected _interface_elements as List = []
	
	virtual interface_elements:
		get:
			return _interface_elements
		
	X as single:
		get:
			return Screen.width*self.x/100
	Y as single:
		get:
			return Screen.height*self.y/100
	W as single:
		get:
			return Screen.width*self.width/100
	H as single:
		get:
			return Screen.height*self.height/100
	
	style as GUIStyle:
		get:
			if not self._style:
				self._style = GUIStyle(GUI.skin.GetStyle("Box"))
			
			self._style.normal.background = self.texture

			return self._style
	
	virtual DrawWindow:
		get:
			return true	
	
	def Awake():
		pass
	
	def OnGUI():
		if DrawWindow:
			GUI.Window(self.WindowID, Rect(self.X, self.Y, self.W, self.H), self.DrawInterfaceElements, "", self.style)

	def DrawInterfaceElements():
		for interface_element as InterfaceElement in self.interface_elements:
			interface_element.DrawInterfaceElement()
		
