import UnityEngine

class SelectedOrbs (MonoBehaviour): 

	public x as int = 105
	public y as int = 10
	public width as int = 90
	public height as int = 20
	
	private orbs_colors = {"Water":"blue", "Fire":"red", "Wind":"green"}
	
	private player as Player

	def Start():
		player = self.GetComponent("Player")

	def OnGUI():
		orbs = player.SelOrbs
		text = ""
		for orb in orbs:
			text = text + "<color=$(orbs_colors[orb])> $(orb) </color>"
		GUI.Box(Rect(x,y,width,height),  text)
