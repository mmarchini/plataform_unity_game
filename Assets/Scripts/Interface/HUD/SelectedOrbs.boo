
class SelectedOrbs(InterfaceElement): 
	DrawBox:
		get:
			return not self.player.paused

	private orbs_colors = {"Water":"blue", "Fire":"red", "Wind":"green"}
	
	text as string:
		get:
			orbs = player.SelOrbs
			selected_orbs = ""
			if orbs:
				for orb in orbs:
					selected_orbs = selected_orbs + "<color=$(orbs_colors[orb])> $(orb) </color>"
			return selected_orbs
