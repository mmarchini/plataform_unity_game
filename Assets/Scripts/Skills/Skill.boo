import UnityEngine

enum SkillType:
	Buff
	Offensive
	Defensive

class Skill (MonoBehaviour): 

	type as SkillType
	orbs as List
	label as string
	description as string
	
	virtual def Execute():
		pass
		
	