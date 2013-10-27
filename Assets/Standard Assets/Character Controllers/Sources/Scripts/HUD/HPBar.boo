import UnityEngine

class HPBar (MonoBehaviour): 

	public x as int = 10
	public y as int = 10
	public width as int = 90
	public height as int = 20
	
	private player as GenericChar

	def Start():
		player = self.GetComponent("GenericChar")

	def OnGUI():
		cur_HP = self.player.HP
		max_HP = self.player.HP
		percent = (cur_HP/max_HP)
		color = ""
		if percent > 0.5:
			color = "lime"
		elif 0.15 < percent:
			color = "yellow"
		else:
			color = "red"
		
		text = "<color=$(color)>$(cur_HP)</color> <color='white'> / $(max_HP)</color>"
		GUI.Box(Rect(x,y,width,height), text)
