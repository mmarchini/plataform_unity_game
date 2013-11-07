import UnityEngine

class BuffController (MonoBehaviour):
	
	
	def Awake():
		pass
		
	def AddBuff(buff_name as string):
		buff = self.GetComponent("Buff$(buff_name)")
		Debug.Log(buff)
		if buff != null:
			(buff as Buff).Reset()
		else:
			self.gameObject.AddComponent("Buff$(buff_name)")
	
	def RemoveBuff(buff_name as string):
		buff = self.GetComponent(buff_name)
		
		if buff != null:
			self.Destroy(buff)
				
	def BuffEffects(character as GenericChar, caller as string):
		buffs = self.GetComponents(Buff)
		extra_attribute = 0.0
		if buffs:
			for buff as Buff in buffs:
				if caller in buff.affected_attributes:
					extra_attribute += buff.Effect(character)
		return extra_attribute

	