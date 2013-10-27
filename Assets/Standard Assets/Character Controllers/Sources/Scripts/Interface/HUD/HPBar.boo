import UnityEngine

class HPBar (InterfaceElement): 
	text as string:
		get:
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
			
			return "HP: <color=$(color)>$(cur_HP)</color> <color='white'> / $(max_HP)</color>"
