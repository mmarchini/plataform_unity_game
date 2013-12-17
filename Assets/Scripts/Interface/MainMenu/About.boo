import UnityEngine

class About(MainMenuItem): 
	itemText as string:
		get:
			return "About"
			
	def Awake():
		super.Awake()
		self.width = 26
		self.height = 10.6
		self.FontSize = 7
		self.x = 11.5
		self.y = 44
	
	def Action():
		print("It's me!")