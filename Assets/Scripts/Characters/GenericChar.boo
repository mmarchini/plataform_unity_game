import UnityEngine

enum ControllerType:
	Player = 1
	Enemy = 2

class GenericChar(GenericCharController):
	
	private buffs as List = []

	[HideInInspector]
	public passive_controller as PassiveController
	[HideInInspector]
	public buff_controller as BuffController
	[HideInInspector]
	public skill_controller as SkillController
	
	public Level as int = 1
	
	public _currentEXP as single = 0.0f
	
	currentEXP:
		get:
			return _currentEXP
		set:
			while value >= self.nextLevelEXP:
				self.Level += 1
				self.LostMP = self.LostMP*0.6
				self.LostHP = self.LostHP*0.25
			self._currentEXP = value
	
	public nextLevelEXP:
		get:
			return self.Level*5 + (self.Level*self.Level)*1.5
		set:
			pass
	
	// Base Attributes
	public baseAttributes = {
		"HP" : 500,
		"MP" : 150,
		"HPSec" : 0,
		"MPSec" : 0.6,
		"ATK" : 50,
		"DEF" : 1,
		"Spear" : 0.05,
		"Shield" : 0.05,
		"ManaShield" : 0.00,
		"ATKRange" : 1,
		"CritChance" : 0.10,
		"CritDamage" : 1.5,
		"Evasion":0.01,
		"BAT" : 1,
		"MovementSpeed" : 4,
		"Jump" : 2,
	}
	
	// Per Level attrbute gain
	public perLevelAttributes = {
		"HP" : 50,
		"MP" : 20,
		"HPSec" : 0,
		"MPSec" : 0.2,
		"ATK" : 2,
		"DEF" : 0.1,
		"Spear" : 0.005,
		"Shield" : 0.005,
		"ManaShield" : 0,
		"ATKRange" : 0,
		"CritChance" : 0,
		"CritDamage" : 0,
		"Evasion":0,
		"BAT" : 0,
		"MovementSpeed" : 0.5,
		"Jump" : 0,
	}
	
	public _LostHP = 0
	LostHP:
		get:
			return _LostHP
		set:
			if value > self.GetCharAttribute("HP"):
				_LostHP = self.GetCharAttribute("HP")
			elif value < 0:
				_LostHP = 0
			else:
				_LostHP = value

	public _LostMP = 0
	LostMP:
		get:
			return _LostMP
			
		set:
			if value > self.GetCharAttribute("MP"):
				_LostMP = self.GetCharAttribute("MP")
			elif value < 0:
				_LostMP = 0
			else:
				_LostMP = value
				
	CurrentHP:
		get:
			return self.GetCharAttribute("HP") - self.LostHP
	CurrentMP:
		get:
			return self.GetCharAttribute("MP") - self.LostMP
			
	def GetCharAttribute(attr as string):
		return (self.baseAttributes[attr] cast single) + (self.perLevelAttributes[attr] cast single)*self.Level + self.Modificators("$(attr)")
	
	Crit:
		get:
			return self.GetCharAttribute("CritDamage") +  self.Modificators("Crit")
	
	DMG:
		get:
			if Random.Range(0,100) <= self.GetCharAttribute("CritChance")*100:
				return self.GetCharAttribute("ATK")*self.Crit + self.SpearATK + self.Modificators("DMG")
			return self.GetCharAttribute("ATK") + self.SpearATK + self.Modificators("DMG")

	Block:
		get:
			#if Random.Range(0,100) <= self.GetCharAttribute("Evasion")*100:
			#	
			#	return self.GetCharAttribute("ATK")*self.GetCharAttribute("CritDamage") + self.SpearATK
			return self.GetCharAttribute("DEF") + self.ShieldDEF + self.Modificators("Block")
	
	virtual jumpHeight:
		get:
			return self.GetCharAttribute("Jump")

	SpearATK:
		get:
			return self.GetCharAttribute("Spear") * self.CurrentMP
			
	ShieldDEF:
		get:
			if self.CurrentHP/self.GetCharAttribute("HP") < 0.25:
				return self.GetCharAttribute("Shield") * self.GetCharAttribute("HP") * 0.25
			return self.GetCharAttribute("Shield") * self.LostHP
	
	public Type as ControllerType;
	
	passivePoints:
		get:
			points = 0
			for i in List(self.passive_controller.passives.Values):
				for p as Passive in i:
					points += p.Level
			return points
	
	def Modificators(attribute as string) as single:
		modificators = 0.0
		if self.passive_controller:
			modificators += passive_controller.CallPassives(self, attribute)
		if self.buff_controller:
			modificators += buff_controller.BuffEffects(self, attribute)
		return modificators
		
	def Start():
		#super.Start()
		self.InvokeRepeating("RestoreEverySeconds", 1, 1)
		
	def RestoreEverySeconds():
		if not self.GetComponent("Buff"):
			self.LostMP -= self.GetCharAttribute("MPSec")
			self.LostHP -= self.GetCharAttribute("HPSec")
	
	def DIE():
		pass
	
	def HPReachZero():
		if _controller and _controller.enabled:
			self._controller.enabled = false
			if action_controller.HasAction("Death"):
				Debug.Log(":D:D:D")
				action_controller.Execute("Death")
			else:
				Destroy(self.gameObject)
	
	virtual def TakeDamage(char_controller as GenericChar, dmg as single):
		self.TakeDamage(char_controller, dmg, "Damaged")
	
	virtual def TakeDamage(char_controller as GenericChar, dmg as single, dmg_action as string):
		block as single = self.Block
		
		if dmg - block < 0:
			block = dmg
		dmg = (dmg - block)
		
		if self.GetCharAttribute("ManaShield"):
			self.LostMP = self.LostMP + dmg*self.GetCharAttribute("ManaShield")
			dmg = dmg - dmg*self.GetCharAttribute("ManaShield")
		self.LostHP = self.LostHP + dmg
		
		if self.CurrentHP <= 0:
			self.HPReachZero()
		elif self.action_controller:
			if not self.action_controller.Executing("Damaged"):
				self.action_controller.Execute(dmg_action)
		else:
			Debug.Log("Char nao tem actioncontroller")
		
