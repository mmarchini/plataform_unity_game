import UnityEngine

class SkillController (MonoBehaviour):
	
	
	def Awake():
		pass
		
	def Execute(char_controller as GenericChar, skill as string):
		cur_skill = GetCurrentSkill(char_controller)
		Debug.Log(cur_skill)
		if cur_skill == "Lava Sword":
			char_controller.buff_controller.AddBuff("LavaSword")
		