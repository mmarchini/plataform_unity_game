import UnityEngine

class BuffController (MonoBehaviour):
	
	
	def Awake():
		pass
		
	def AddBuff(buff_name as string):
		Debug.Log("Add")
		buff = self.GetComponent("Buff$(buff_name)")
		if buff != null:
			(buff as Buff).Reset()
		else:
			buff = self.gameObject.AddComponent("Buff$(buff_name)")
		if not buff:
			Debug.Log("Nao foi possivel adicionar o buff $(buff_name)")
	
	def RemoveBuff(buff_name as string):
		Debug.Log("Remove")
		buff = self.GetComponent("Buff$(buff_name)")
		
		if buff != null:
			self.Destroy(buff)
		
	def ToggleBuff(buff_name as string):
		Debug.Log("Toggle")
		buff = self.GetComponent("Buff$(buff_name)")
		
		if buff:
			self.RemoveBuff(buff_name)
		else:
			self.AddBuff(buff_name)
				
	def BuffEffects(character as GenericChar, caller as string):
		buffs = self.GetComponents(Buff)
		extra_attribute = 0.0
		if buffs:
			for buff as Buff in buffs:
				if caller in buff.affected_attributes:
					extra_attribute += buff.Effect(caller)
		return extra_attribute

	