import UnityEngine

class Enemy (GenericChar): 
	private lastAIMovement = -10
	private AIMovementDuration = 0
	private AIMovementDirection = 0
	public dropEXP as single = 15.0f
	
	def OnDestroy():
		playergo = GameObject.FindGameObjectWithTag("Player")
		player as Player = playergo.GetComponent("Player")
		player.currentEXP += self.dropEXP
		
	
	def Update():
		if lastAIMovement + AIMovementDuration < Time.time:
			self.AIMovementDuration = Random.Range(1.0F, 2.0F)
			self.AIMovementDirection = Random.Range(0.0F, 100.0F)
			if self.AIMovementDirection > 70.0:
				self.AIMovementDirection = 0.0
			elif self.AIMovementDirection < 35.0:
				self.AIMovementDirection = -1.0
			else:
				self.AIMovementDirection = 1.0
			self.lastAIMovement = Time.time
		super.Update()
	
	def GetHorizontalSpeed():
		return self.AIMovementDirection
	
	def IsJumping():
		return false
	
	def ExecuteAttack():
		return false
	
	def DealDamage(char_controller as GenericChar):
		self.AIMovementDuration = Random.Range(1.3F, 2.8F)
		self.AIMovementDirection = 0.0
		self.lastAIMovement = Time.time
		super.DealDamage(char_controller)
	
	def OnAnotherControllerHit(hit as ControllerColliderHit):
		pass
	
