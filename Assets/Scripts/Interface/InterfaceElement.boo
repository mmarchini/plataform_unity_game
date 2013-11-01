import UnityEngine

class InterfaceElement (MonoBehaviour): 

	public x as single = 10.0f
	public y as single = 10.0f
	public width as single = 10.0f
	public height as single = 10.0f
	public FontSize as single = 5.0f
	
	public TextX as single = 1.0f
	public TextY as single = 1.0f
	
	public texture as Texture2D
	
	protected gui_path as string = "NecromancerGUI/controls"
	
	private _style as GUIStyle
	
	virtual X as single:
		get:
			return Screen.width*self.x/100
	virtual Y as single:
		get:
			return Screen.height*self.y/100
	W as single:
		get:
			return Screen.width*self.width/100
	H as single:
		get:
			return Screen.height*self.height/100
	TX:
		get:
			return Screen.width*self.TextX/100
	TY:
		get:
			return Screen.height*self.TextY/100
	FS as single:
		get:
			return (Screen.width cast single) * self.FontSize/200
	
	style as GUIStyle:
		get:
			if not self._style:
				self._style = GUIStyle(GUI.skin.GetStyle("Box"))
			
			self._style.normal.background = self.texture
			self._style.padding.left = self.TX
			self._style.padding.right = self.TX
			self._style.padding.top = self.TY
			self._style.fontSize = self.FS
			return self._style
	
	virtual text as string:
		get:
			return ""
			
	virtual DrawBox:
		get:
			return true
	
	protected player as Player
	
	virtual def BeforeBoxDraw():
		pass
		
	virtual def AfterBoxDraw():
		pass
		
	def Awake():
		player = self.GetComponent("Player")
		
	virtual def DrawInterfaceElement():
		self.BeforeBoxDraw()
		if self.DrawBox:
			GUI.Box(Rect(X,Y,W,H), self.text, self.style)
		self.AfterBoxDraw()
