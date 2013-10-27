import UnityEngine

class MPBar (MonoBehaviour): 

	public x as int = 10
	public y as int = 35
	public width as int = 90
	public height as int = 20
	
	private player as GenericChar

	def Start():
		player = self.GetComponent("GenericChar")

	def OnGUI():
		cur_MP = self.player.MP
		max_MP = self.player.MP
		percent = (cur_MP/max_MP)
		color = ""
		if percent > 0.5:
			color = "blue"
		elif 0.15 < percent:
			color = "yellow"
		else:
			color = "red"
		
		text = "<color=$(color)>$(cur_MP)</color> <color='white'> / $(max_MP)</color>"
		GUI.Box(Rect(x,y,width,height), text)
