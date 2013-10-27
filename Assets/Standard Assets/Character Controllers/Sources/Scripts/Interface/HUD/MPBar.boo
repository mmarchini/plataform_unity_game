import UnityEngine

class MPBar (InterfaceElement): 
	text as string:
		get:
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
				
			return "<color=$(color)>$(cur_MP)</color> <color='white'> / $(max_MP)</color>"
