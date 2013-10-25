import UnityEngine

enum ControllerType:
	Player = 1
	Enemy = 2

class GenericChar(GenericCharController): 
	// Atributos
	public HP = 500;
	public MP = 150;
	public ATK = 14;
	public DEF = 1;
	public Spear = 0.05;
	public Shield = 0.05;
	public ATKRange = 1;
	public CritChance = 0.10;
	public CritDamage = 1.5;
	public BAT = 1;
	public MovementSpeed = 1;
	public Jump = 1;
	
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
			self.HP = self.HP - char_controller.ATK
		self.StartDamage()
	
	def DealDamage(char_controller as GenericChar):
		char_controller.TakeDamage(self)
	