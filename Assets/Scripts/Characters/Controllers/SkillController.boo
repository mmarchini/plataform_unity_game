import UnityEngine

struct Skill:
	label as string
	call as string
	type as string
	neededMP as single
	spentMP as single
	neededHP as single
	spentHP as single
	

class SkillController (MonoBehaviour):
	
	def Execute(char_controller as GenericChar, skill as Skill):
		
		if char_controller.CurrentMP >= skill.neededMP and char_controller.CurrentHP >= skill.neededHP:
			if skill.type == "Action":
				char_controller.LostMP += skill.spentMP
				char_controller.LostHP += skill.spentHP
				char_controller.action_controller.Execute(skill.call)
			
			elif skill.type == "PermaBuff":
				char_controller.LostMP += skill.spentMP
				char_controller.LostHP += skill.spentHP
				char_controller.buff_controller.ToggleBuff(skill.call)
			
			elif skill.type == "Buff":
				char_controller.LostMP += skill.spentMP
				char_controller.LostHP += skill.spentHP
				char_controller.buff_controller.AddBuff(skill.call)		