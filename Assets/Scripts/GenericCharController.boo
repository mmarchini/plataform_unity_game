﻿#@script RequireComponent(CharacterController);

import UnityEngine

enum CharacterState:
	Idle = 0
	Walking = 1
	Jumping = 2
	Attacking = 3
	Hitted = 4

class GenericCharController(MonoBehaviour): 
	public idleAnimation as AnimationClip
	public walkAnimation as AnimationClip
	public attackAnimation as AnimationClip
	public onHitAnimation as AnimationClip
	public jumpPoseAnimation as AnimationClip
	
	public walkMaxAnimationSpeed  = 0.75f
	public jumpAnimationSpeed  = 1.15f
	public attackAnimationSpeed = 1.15f
	public onHitAnimationSpeed  = 1.15f
	public landAnimationSpeed  = 1.0f

	public walkSpeed = 4.0
	
	// How high do we jump when pressing jump and letting go immediately
	public jumpHeight = 0.5
	
	// The gravity for the character
	public gravity = 25.0
	// The gravity in controlled descent mode
	public speedSmoothing = 70.0
	public rotateSpeed = 5000.0
	
	public canJump = true
			
	protected _animation as Animation
	protected _controller as CharacterController

	private jumpRepeatTime = 0.05
	private jumpTimeout = 0.15
	private groundedTimeout = 0.25
	
	// The camera doesnt start following the target immediately but waits for a split second to avoid too much waving around.
	private lockCameraTimer = 0.0
	
	// The current vertical speed
	private verticalSpeed = 0.0
	
	// The last collision flags returned from controller.Move
	private collisionFlags as CollisionFlags 
	
	// Are we jumping? (Initiated with jump button and not grounded yet)
	protected _jumping = false
	private jumpingReachedApex = false
	
	protected attacking = false
	protected startAttackingTime = -10
	protected middleOfAttack = false
	
	damaged:
		get:
			return _animation.IsPlaying(onHitAnimation.name)
	
	
	// Last time the jump button was clicked down
	private lastJumpButtonTime = -10.0
	// Last time we performed a jump
	protected lastJumpTime = -1.0
	
	// the height we jumped from (Used to determine for how long to apply extra jump power after jumping.)
	private lastJumpStartHeight = 0.0
	
	
	private lastGroundedTime = 0.0
		
	private isControllable = true
	
	def Awake():
		
		_animation = GetComponent(Animation)
		_controller = GetComponent(CharacterController)
		if not _animation:
			Debug.Log("The character you would like to control doesn't have animations. Moving her might look weird.")
	
		if not idleAnimation:
			_animation = null
			Debug.Log("No idle animation found. Turning off animations.")
		if not walkAnimation:
			_animation = null
			Debug.Log("No walk animation found. Turning off animations.")
		if not jumpPoseAnimation and canJump:
			_animation = null
			Debug.Log("No jump animation found and the character has canJump enabled. Turning off animations.")
		
		_event = AnimationEvent()
		_event.functionName = "EndAttack"
		_event.time = attackAnimation.length-0.1f
		attackAnimation.AddEvent(_event)
		
		#event2 = AnimationEvent()
		#event2.functionName = "EndDamage"
		#event2.time = -1
		#onHitAnimation.AddEvent(event2)
	
	def GetRightVector():
		cameraTransform = Camera.main.transform

		// Forward vector relative to the camera along the x-z plane	
		forward = cameraTransform.TransformDirection(Vector3.forward)
		forward.y = 0
		forward = forward.normalized
	
		// Right vector relative to the camera
		// Always orthogonal to the forward vector
		right = Vector3(forward.z, 0, -forward.x)
		
		return right
	
	targetDirection:
		get:
			if not attacking:
				return self.GetHorizontalSpeed() * GetRightVector()
			else:
				return self.transform.forward.normalized
	
	isMoving :
		get:
			return Mathf.Abs (self.GetHorizontalSpeed()) > 0.1
			
	moveDirection:
		get:
			_moveDirection as Vector3
			if targetDirection != Vector3.zero and not ((attacking and Grounded) or damaged):
				_moveDirection = targetDirection.normalized
			else:
				_moveDirection = self.transform.forward
			
			return _moveDirection.normalized
			
	moveSpeed:
		get:
			if (attacking and Grounded) or damaged:
				return 0
			return Mathf.Min(targetDirection.magnitude, 1.0) * self.GetWalkSpeed()
	
	_characterState:
		get:
			if damaged :
				return CharacterState.Hitted
			elif attacking:
				return CharacterState.Attacking
			elif Jumping:
				return CharacterState.Jumping
			elif moveSpeed != 0:
				return CharacterState.Walking
			else:
				return CharacterState.Idle
	
	def ApplyDamage():
		if damaged:
			pass
	
	def Raycast(direction as Vector3, range as single):
		ray = Ray(GetCharPosition(), direction)
		
		Debug.DrawRay(ray.origin, ray.direction*range, Color.black, 0)
		
		raycasthit as RaycastHit
		
		if Physics.Raycast(ray, raycasthit, range):
			if raycasthit.collider != null:
				if raycasthit.collider.gameObject != null:
					if raycasthit.collider.gameObject.GetComponent("GenericChar") != null:
						char_controller as GenericChar = raycasthit.collider.gameObject.GetComponent("GenericChar")
						if char_controller != null:
							return char_controller
		return null
		
		
	def ApplyAttack():
		if self.ExecuteAttack():
			self.StartAttack()
			
		if self.attacking:
			char_controller = self.Raycast(moveDirection, self.GetATKRange())
			if char_controller != null:
				if char_controller.tag != self.tag:
					if not char_controller.damaged:
						self.DealDamage(char_controller)
	
	def ApplyJumping():
		// Prevent jumping too fast after each other
		if lastJumpTime + jumpRepeatTime > Time.time:
			return
	
		if Grounded and Jumping:
			// Jump
			// - Only when pressing the button down
			// - With a timeout so you can press the button slightly before landing		
			if Time.time < lastJumpButtonTime + jumpTimeout:
				verticalSpeed = CalculateJumpVerticalSpeed (jumpHeight)
				SendMessage("DidJump", SendMessageOptions.DontRequireReceiver)
	
	def ApplyGravity():

		verticalSpeed -= gravity * Time.deltaTime
	
	def CalculateJumpVerticalSpeed (targetJumpHeight as single):
		// From the jump height and gravity we deduce the upwards speed 
		// for the character to reach at the apex.
		return Mathf.Sqrt(2 * targetJumpHeight * gravity)
	
	def DidJump():
		_jumping = true
		jumpingReachedApex = false
		lastJumpTime = Time.time
		lastJumpStartHeight = transform.position.y
		lastJumpButtonTime = -10
	
	virtual def StartDamage():
		attacking = false
		_jumping = false
		_animation[onHitAnimation.name].speed = onHitAnimationSpeed
		_animation.Play(onHitAnimation.name)
	
	virtual def EndAttack():
		attacking = false
	
	virtual def StartAttack():
		attacking = true
		startAttackingTime = Time.time
		middleOfAttack = false
	
	virtual JumpAction:
		get:
			return false
	
	def MoveChar():
		movement = moveDirection * moveSpeed
		if(attacking and Grounded):
			movement *= 0
		movement += Vector3 (0, verticalSpeed, 0)
		
		movement *= Time.deltaTime
		
		collisionFlags = _controller.Move(movement)
			
		// Set rotation to the move direction
		if not damaged:
			if Grounded:
				transform.rotation = Quaternion.LookRotation(moveDirection)
			else:
				xzMove = movement
				xzMove.y = 0
				if xzMove.sqrMagnitude > 0.001:
					transform.rotation = Quaternion.LookRotation(xzMove)
		
		// We are in jump mode but just became grounded
		if Grounded:
			lastGroundedTime = Time.time
			if Jumping:
				_jumping = false
				SendMessage("DidLand", SendMessageOptions.DontRequireReceiver)
	
	def UpdateAnimation():
		// ANIMATION sector
		if _animation:
			if _characterState == CharacterState.Hitted:
				if not _animation.IsPlaying(onHitAnimation.name):
					_animation[onHitAnimation.name].speed = onHitAnimationSpeed
					_animation.Play(onHitAnimation.name)
			elif _characterState == CharacterState.Attacking:
				_animation[attackAnimation.name].speed = attackAnimationSpeed
				_animation.CrossFade(attackAnimation.name)
			elif _characterState == CharacterState.Jumping:
				_animation[jumpPoseAnimation.name].speed = jumpAnimationSpeed
				#_animation[jumpPoseAnimation.name].wrapMode = WrapMode.ClampForever
				_animation.CrossFade(jumpPoseAnimation.name)
			elif(_characterState == CharacterState.Walking):
				_animation[walkAnimation.name].speed = Mathf.Clamp(_controller.velocity.magnitude, 0.0, walkMaxAnimationSpeed)
				_animation.CrossFade(walkAnimation.name)
			elif(_characterState == CharacterState.Idle):
				_animation.CrossFade(idleAnimation.name)
	
	virtual def GetATKRange():
		#TODO apagar essa merda depois
		return 0.0f cast double
		
	virtual def DealDamage(lala as GenericChar):
		#TODO apagar essa merda depois
		return 0.0f
		
	
					
	def Action():
		
		// Apply gravity
		ApplyGravity()
		
		// Apply jumping logic
		ApplyJumping()
		
		MoveChar()
		
		ApplyAttack()
		
		ApplyDamage()
	
	def GetCharPosition():
		return Vector3(self.gameObject.transform.position.x,self.gameObject.transform.position.y+0.7,self.gameObject.transform.position.z)
	
	def Update():
		if self.Jumping:
			lastJumpButtonTime = Time.time
		
		Action()
		
		UpdateAnimation()
	
	def OnControllerColliderHit(hit as	ControllerColliderHit):
		if hit.moveDirection.y > 0.01:
			return
	
	virtual def GetWalkSpeed():
		return walkSpeed
	
	Jumping:
		get:
			if self.damaged:
				return false
			elif self.JumpAction:
				return true
			elif _jumping:
				return true
			else:
				return false
	
	Grounded:
		get:
 	 		return (not self._jumping) or (self._controller.isGrounded)
	
	def GetDirection():
		return moveDirection
	
	def GetLockCameraTimer():
		return lockCameraTimer
	
	def IsMoving():
		return Mathf.Abs(Input.GetAxisRaw("Horizontal")) > 0.5
	
	def HasJumpReachedApex():
		return jumpingReachedApex
	
	def IsGroundedWithTimeout():
		return lastGroundedTime + groundedTimeout > Time.time
	
	virtual def GetHorizontalSpeed():
		return Input.GetAxisRaw("Horizontal")
	
	virtual def ExecuteAttack():
		return false
	
	def Reset ():
		gameObject.tag = "Player"
