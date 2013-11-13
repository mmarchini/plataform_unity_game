import UnityEngine

enum ControllerType:
	Player = 1
	Enemy = 2

class GenericChar(GenericCharController):
	
	private already_hitted as List = []
	
	private buffs as List = []
			
	public passive_controller as PassiveController
	
	public buff_controller as BuffController
	
	public skill_controller as SkillController
	
	public Level as int = 1
	
	public _currentEXP as single = 0.0f
	
	currentEXP:
		get:
			return _currentEXP
		set:
			while value >= self.nextLevelEXP:
				self.Level += 1
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
		"ATK" : 50,
		"DEF" : 1,
		"Spear" : 0.05,
		"Shield" : 0.05,
		"ATKRange" : 1,
		"CritChance" : 0.10,
		"CritDamage" : 1.5,
		"Evasion":0.01,
		"BAT" : 1,
		"MovementSpeed" : 1,
		"Jump" : 1,
	}
	
	// Per Level attrbute gain
	public perLevelAttributes = {
		"HP" : 0,
		"MP" : 0,
		"ATK" : 0,
		"DEF" : 0,
		"Spear" : 0,
		"Shield" : 0,
		"ATKRange" : 0,
		"CritChance" : 0,
		"CritDamage" : 0,
		"Evasion":0,
		"BAT" : 0,
		"MovementSpeed" : 0,
		"Jump" : 0,
	}
	
	public _LostHP = 0
	LostHP:
		get:
			return _LostHP
		set:
			if _LostHP + value > self.GetCharAttribute("HP"):
				_LostHP = self.GetCharAttribute("HP")
			elif _LostHP + value < 0:
				_LostHP = 0
			else:
				_LostHP += value

	public LostMP = 0

	CurrentHP:
		get:
			return self.GetCharAttribute("HP") - self.LostHP
	CurrentMP:
		get:
			return self.GetCharAttribute("MP") - self.LostMP
			
	def GetCharAttribute(attr as string):
		return (self.baseAttributes[attr] cast single) + (self.perLevelAttributes[attr] cast single)*self.Level + self.Modificators("$(attr)")
	
	DMG:
		get:
			if Random.Range(0,100) <= self.GetCharAttribute("CritChance")*100:
				return self.GetCharAttribute("ATK")*self.GetCharAttribute("CritDamage") + self.SpearATK
			return self.GetCharAttribute("ATK") + self.SpearATK

	Block:
		get:
			#if Random.Range(0,100) <= self.GetCharAttribute("Evasion")*100:
			#	
			#	return self.GetCharAttribute("ATK")*self.GetCharAttribute("CritDamage") + self.SpearATK
			return self.GetCharAttribute("DEF") + self.ShieldDEF


	SpearATK:
		get:
			return self.GetCharAttribute("Spear") * self.CurrentMP
			
	ShieldDEF:
		get:
			return self.GetCharAttribute("Shield") * self.CurrentHP
	
	public Type as ControllerType;
	
	passivePoints:
		get:
			points = 0
			for i in List(self.passive_controller.passives.Values):
				for p as Passive in i:
					points += p.Level
			return points
	
	def Modificators(attribute as string) as single:
		modificators = 0
		if self.passive_controller:
			modificators += passive_controller.CallPassives(self, attribute)
		if self.buff_controller:
			modificators += buff_controller.BuffEffects(self, attribute)
		return modificators
		
	
	def GetATKRange():
		#currentAttackTime = Time.time - self.startAttackingTime
		#endAttackTime = self._animation[self.attackAnimation.name].length
		#return (ATKRange cast double)*((currentAttackTime cast double)/(endAttackTime cast double))
		return self.GetCharAttribute("ATKRange")

	def GetWalkSpeed():
		horizontalSpeed as single = self.walkSpeed * self.GetCharAttribute("MovementSpeed")
		if Mathf.Abs(horizontalSpeed) > 5.5:
			return 5.5*(horizontalSpeed/Mathf.Abs(horizontalSpeed))
		if Mathf.Abs(horizontalSpeed) < 3 and horizontalSpeed != 0:
			return 3*(horizontalSpeed/Mathf.Abs(horizontalSpeed))
		return horizontalSpeed
	
	def GetHorizontalSpeed():
		return 0
	
	def IsJumping():
		return false
		
	def ExecuteAttack():
		return false
		
	def EndAttack():
		self.already_hitted = []
		super.EndAttack()
	
	virtual def TakeDamage(char_controller as GenericChar):
		if not damaged:
			Debug.Log(self.Block)
			self.LostHP = self.LostHP + (char_controller.DMG - self.Block)
		if self.CurrentHP <= 0:
			Destroy(self.gameObject)
		self.StartDamage()
	
	virtual def DealDamage(char_controller as GenericChar):
		if char_controller not in self.already_hitted:
			self.already_hitted.Add(char_controller)
			char_controller.TakeDamage(self)
