import UnityEngine

class SkillController (MonoBehaviour):
	
	def Execute(char_controller as GenericChar, skill as string):
		cur_skill = GetCurrentSkill(char_controller)
		Debug.Log(cur_skill)
		if cur_skill == "Lava Sword":
			char_controller.buff_controller.AddBuff("LavaSword")
		if cur_skill == "Aerial Movement":
			char_controller.buff_controller.AddBuff("AerialMovement")
		if cur_skill == "Hot Steam":
			char_controller.buff_controller.AddBuff("HotSteam")
		if cur_skill == "Water Suit":
			char_controller.buff_controller.AddBuff("WaterSuit")
		if cur_skill == "Wild Tornado":
			char_controller.buff_controller.AddBuff("WildTornado")
		
		if cur_skill == "Fire Ball":
			char_controller.action_controller.Execute("FireBall")	
		if cur_skill == "Fire Slash":
			char_controller.action_controller.Execute("FireSlash")
		if cur_skill == "Wind Strike":
			char_controller.action_controller.Execute("WindStrike")
		if cur_skill == "Ultimate Stab":
			char_controller.action_controller.Execute("UltimateStab")
		if cur_skill == "Liquid Cut":
			char_controller.action_controller.Execute("LiquidCut")
		
		