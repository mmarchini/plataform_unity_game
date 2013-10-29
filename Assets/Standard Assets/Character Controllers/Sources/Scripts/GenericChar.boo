import UnityEngine

enum ControllerType:
	Player = 1
	Enemy = 2

class GenericChar(GenericCharController):
	
	
	// Atributos
	public BaseHP = 500
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
	public BaseMP = 150
	public LostMP = 0
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

	MaxHP:
		get:
			return self.BaseHP
	CurrentHP:
		get:
			return self.BaseHP - self.LostHP
	MaxMP:
		get:
			return self.BaseMP
	CurrentMP:
		get:
			return self.BaseMP - self.LostMP
	
	ATK:
		get:
			return self.BaseATK
			
	DEF:
		get:
			return self.BaseDEF
	Spear:
		get:
			return self.BaseSpear
	Shield:
		get:
			return self.BaseShield
			
	ATKRange:
		get:
			return self.BaseATKRange
	CritChance:
		get:
			return self.BaseCritChance
	CritDamage:
		get:
			return self.BaseCritDamage
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
	
	def GetATKRange():
		//var currentAttackTime = Time.time - self.startAttackingTime;
		//var endAttackTime = self.attackAnimation.length;
		//return ATKRange*(currentAttackTime/endAttackTime);
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
	
	def TakeDamage(char_controller as GenericChar):
		if not damaged:
			self.LostHP = self.LostHP + char_controller.ATK
		self.StartDamage()
	
	def DealDamage(char_controller as GenericChar):
		char_controller.TakeDamage(self)
	