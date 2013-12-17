import UnityEngine

class End2 (InterfaceElement): 

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
Final 2
Parabens, 
voce conseguiu
encontrar a 
saida da fortaleza!</color>"""
		