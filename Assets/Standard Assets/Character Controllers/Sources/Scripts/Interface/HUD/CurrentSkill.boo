import UnityEngine

class CurrentSkill (InterfaceElement): 
	
	private elements_list = ["Fire", "Wind", "Water"]
	private skills_dict = {
			["Fire" , "Fire" , "Fire" ] : "Fire Ball",
			["Fire" , "Fire" , "Wind" ] : "Fire Slash",
			["Fire" , "Fire" , "Water"] : "Lava Sword",
			["Water", "Water", "Water"] : "Water Suit",
			["Water", "Water", "Wind" ] : "???",
			["Water", "Water", "Fire" ] : "Hot Steam",
			["Wind" , "Wind" , "Wind" ] : "???",
			["Wind" , "Wind" , "Fire" ] : "Wild Tornado",
			["Wind" , "Wind" , "Water"] : "???",
			["Fire" , "Water", "Wind" ] : "???",
		}
	
	text as string:
		get:
			
			orbs = player.SelOrbs
			cur_skill as List
			for skill as List in skills_dict.Keys:
				this_skill = true
				for element in elements_list:
					if len(skill.Collect({item | return item == element})) != len(orbs.Collect({item | return item == element})):
						this_skill = false
				if this_skill:
					cur_skill = skill
					break
			_text as string = skills_dict[cur_skill]
			return _text
