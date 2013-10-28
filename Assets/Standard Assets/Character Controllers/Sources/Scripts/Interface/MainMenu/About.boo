import UnityEngine

class About(MainMenuItem): 
	itemText as string:
		get:
			return "About"
			
	def Action():
		print("It's me!")