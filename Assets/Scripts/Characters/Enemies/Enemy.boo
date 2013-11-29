﻿import UnityEngine

class Enemy (GenericChar): 
	private lastAIMovement = -10
	private lastAIAttack = -10
	private AIMovementDuration = 0
	public AIAttackDelay = 6
	private AIMovementDirection = 0
	public dropEXP as single = 15.0f
	public damageClip as AudioClip
	
	public chanceOfAttack as single = 15.0f
			
	def OnDestroy():
		playergo = GameObject.FindGameObjectWithTag("Player")
		if playergo:
			player as Player = playergo.GetComponent("Player")
			if player:
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
	
	horizontalSpeed:
		get:
			return self.AIMovementDirection
	
	def IsJumping():
		return false
	
	def Control():
		if self.ExecuteAttack():
			if self.action_controller:
				self.action_controller.Execute("BaseAttack")
			
	
	def ExecuteAttack():
		if Time.time - lastAIAttack > AIAttackDelay:
			if Random.Range(0.0F, 100.0F) <= self.chanceOfAttack:
				lastAIAttack = Time.time
				return true
		return false
	
	#def DealDamage(char_controller as GenericChar):
	#	self.AIMovementDuration = Random.Range(1.3F, 2.8F)
	#	self.AIMovementDirection = 0.0
	#	self.lastAIMovement = Time.time
	#	super.DealDamage(char_controller)
	
	#def StartDamage():
	#	if not self.damaged:
	#		(self.GetComponent("AudioSource") as AudioSource).PlayOneShot(self.damageClip,1.0)
	#		super.StartDamage()
	