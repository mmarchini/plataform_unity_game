﻿import UnityEngine

enum ControllerType:
	Player = 1
	Enemy = 2

class GenericChar(GenericCharController):

	private already_hitted as List = []
			
	public passive_controller as PassiveController
	
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
	public BaseHP = 500
	public BaseMP = 150
	public BaseATK = 14
	public BaseDEF = 1
	public BaseSpear = 0.05
	public BaseShield = 0.05
	public BaseATKRange = 1
	public BaseCritChance = 0.10
	public BaseCritDamage = 1.5
	public BaseBAT = 1
	public BaseMovementSpeed = 1
	public BaseJump = 1

	// Per Level attrbute gain
	public PerLevelHP = 0
	public PerLevelMP = 0
	public PerLevelATK = 0
	public PerLevelDEF = 0
	public PerLevelSpear = 0
	public PerLevelShield = 0
	public PerLevelCritDamage = 0

	public _LostHP = 0
	LostHP:
		get:
			return _LostHP
		set:
			if _LostHP + value > self.MaxHP:
				_LostHP = self.MaxHP
			elif _LostHP + value < 0:
				_LostHP = 0
			else:
				_LostHP += value

	public LostMP = 0

	MaxHP:
		get:
			return self.BaseHP + self.PerLevelHP*self.Level + self.Passives("HP")
	CurrentHP:
		get:
			return self.MaxHP - self.LostHP
	MaxMP:
		get:
			return self.BaseMP + self.PerLevelMP*self.Level + self.Passives("MP")
	CurrentMP:
		get:
			return self.MaxMP - self.LostMP
	
	ATK:
		get:	
			return self.BaseATK + self.PerLevelATK*self.Level + self.Passives("ATK")
	
	DMG:
		get:
			if Random.Range(0,100) <= self.CritChance:
				return self.ATK*self.CritDamage
			return self.ATK + self.SpearATK
						
	DEF:
		get:
			return self.BaseDEF + self.PerLevelDEF*self.Level + self.Passives("DEF") + self.ShieldDEF
			
	Spear:
		get:
			return self.BaseSpear + self.PerLevelSpear*self.Level
	Shield:
		get:
			return self.BaseShield + self.PerLevelShield*self.Level
	
	SpearATK:
		get:
			return self.Spear * self.CurrentMP
			
	ShieldDEF:
		get:
			return self.Spear * self.CurrentHP
	
	ATKRange:
		get:
			return self.BaseATKRange
	CritChance:
		get:
			return self.BaseCritChance
	CritDamage:
		get:
			return self.BaseCritDamage + self.PerLevelCritDamage*self.Level + self.Passives("CritDamage")
	BAT:
		get:
			return self.BaseBAT
	MovementSpeed:
		get:
			return self.BaseMovementSpeed
	Jump:
		get:
			return self.BaseJump
	
	public Type as ControllerType;
	
	passivePoints:
		get:
			points = 0
			for i in List(self.passive_controller.passives.Values):
				for p as Passive in i:
					points += p.Level
			return points
			
	
	def Passives(attribute as string) as single:
		if self.passive_controller:
			return passive_controller.CallPassives(self, attribute)
		return 0
		
	def GetATKRange():
		#currentAttackTime = Time.time - self.startAttackingTime
		#endAttackTime = self._animation[self.attackAnimation.name].length
		#return (ATKRange cast double)*((currentAttackTime cast double)/(endAttackTime cast double))
		return ATKRange

	def GetWalkSpeed():
		horizontalSpeed as single = self.walkSpeed * self.MovementSpeed
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
	
	def TakeDamage(char_controller as GenericChar):
		if not damaged:
			self.LostHP = self.LostHP + char_controller.DMG
		if self.CurrentHP <= 0:
			Destroy(self.gameObject)
		self.StartDamage()
	
	def DealDamage(char_controller as GenericChar):
		if char_controller not in self.already_hitted:
			self.already_hitted.Add(char_controller)
			char_controller.TakeDamage(self)
	