
class MPBar (InterfaceElement): 
	
	DrawBox:
		get:
			return not self.player.paused
	text as string:
		get:
			cur_MP as single = self.player.CurrentMP
			max_MP as single = self.player.MaxMP
			percent = (cur_MP/max_MP)
			color = ""
			if percent > 0.5:
				color = "blue"
			elif 0.15 < percent:
				color = "yellow"
			else:
				color = "red"
				
			return "<color=$(color)>$(cur_MP)</color> <color='white'> / $(max_MP)</color>"
