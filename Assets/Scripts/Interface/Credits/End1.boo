import UnityEngine

class End1(InterfaceElement): 

	def Awake():
		super.Awake()
		self.width = 50
		self.height = 60
		self.FontSize = 9
		self.TextX = 1
		self.TextY= 5
		self.texture = Resources.Load("$(self.gui_path)/window") as Texture

	text as string:
		get:
			return """<color='black'>
Final 1
existe outro final...
tente encontrar 
todas as passivas.</color>"""
	