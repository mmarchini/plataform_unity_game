
class About(MainMenuItem): 
	itemText as string:
		get:
			return "About"
			
	def Awake():
		super.Awake()
		self.x = 15
		self.y = 44
	
	def Action():
		print("It's me!")