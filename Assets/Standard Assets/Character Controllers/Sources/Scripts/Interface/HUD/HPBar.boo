import UnityEngine

class HPBar (InterfaceElement): 
	text as string:
		get:
			cur_HP as single = self.player.CurrentHP
			max_HP as single = self.player.MaxHP
			percent = (cur_HP/max_HP)
			color = ""
			if percent > 0.5:
				color = "lime"
			elif 0.15 < percent:
				color = "yellow"
			else:
				color = "red"
			
			return "HP: <color=$(color)>$(cur_HP)</color> <color='white'> / $(max_HP)</color>"
