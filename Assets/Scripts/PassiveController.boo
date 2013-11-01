import UnityEngine

class PassiveController (MonoBehaviour):
	
	public passives = {}
	
	public generic_char as GenericChar
	
	def Awake():
		self.passives = {}
		
		passives_names = ["ATK", "DEF", "HP", "MP", "CritDamage"]
		for pn in passives_names:
			aux_passive as Passive = self.gameObject.AddComponent("Passive$(pn)")
			if aux_passive and aux_passive.AffectAttribute:
				aux_list = []
				if self.passives.ContainsKey(aux_passive.AffectAttribute):
					aux_list = self.passives[aux_passive.AffectAttribute]
				
				aux_list += [aux_passive]
					
				self.passives[aux_passive.AffectAttribute] = aux_list
		
				
	def CallPassives(character as GenericChar, caller as string):
		attribute_passives as List = passives[caller]
		extra_attribute = 0.0
		if attribute_passives:
			for ap as Passive in attribute_passives:
				extra_attribute += ap.Effect(character)
		else:
			Debug.Log("$(caller) has no passives!")
		return extra_attribute

	