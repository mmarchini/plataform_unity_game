#@script RequireComponent(CharacterController);

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
	public onHitTakenSpeed = 5f

	public walkSpeed = 4.0
	
	// How high do we jump when pressing jump and letting go immediately
	public jumpHeight = 0.5
	
	// The gravity for the character
	public gravity = 25.0
	// The gravity in controlled descent mode
	public speedSmoothing = 70.0
	public rotateSpeed = 5000.0
	
	public canJump = true
			
	private _animation as Animation
	private _controller as CharacterController
	private _characterState as CharacterState

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
	protected jumping = false
	private jumpingReachedApex = false
	
	protected attacking = false
	protected startAttackingTime = -10
	protected middleOfAttack = false
	
	protected damaged = false
	
	
	// Last time the jump button was clicked down
	private lastJumpButtonTime = -10.0
	// Last time we performed a jump
	private lastJumpTime = -1.0
	
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
		
		event2 = AnimationEvent()
		event2.functionName = "EndDamage"
		event2.time = onHitAnimation.length-0.1f
		onHitAnimation.AddEvent(event2)
	
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
			return self.GetHorizontalSpeed() * GetRightVector()
	
	isMoving :
		get:
			return Mathf.Abs (self.GetHorizontalSpeed()) > 0.1
			
	moveDirection:
		get:
			_moveDirection as Vector3
			if targetDirection != Vector3.zero and not ((attacking and IsGrounded()) or damaged):
				// If we are really slow, just snap to the target direction
				if moveSpeed < self.GetWalkSpeed() * 0.9 and IsGrounded():
					_moveDirection = targetDirection.normalized
				// Otherwise smoothly turn towards it
				else:
					_moveDirection = Vector3.RotateTowards(_moveDirection, targetDirection, rotateSpeed * Mathf.Deg2Rad * Time.deltaTime, 1000)
			else:
				_moveDirection = self.transform.forward
			
			return _moveDirection.normalized
			
	moveSpeed:
		get:
			if (attacking and IsGrounded()) or damaged:
				return 0
			return Mathf.Min(targetDirection.magnitude, 1.0) * self.GetWalkSpeed()
	
	def ApplyDamage():
		if damaged:
			_characterState = CharacterState.Hitted
	
	def ApplyAttack():
		if self.ExecuteAttack():
			self.StartAttack()
		if attacking:
			_characterState = CharacterState.Attacking
	
	def ApplyJumping():
		// Prevent jumping too fast after each other
		if lastJumpTime + jumpRepeatTime > Time.time:
			return
	
		if IsGrounded():
			// Jump
			// - Only when pressing the button down
			// - With a timeout so you can press the button slightly before landing		
			if Time.time < lastJumpButtonTime + jumpTimeout:
				verticalSpeed = CalculateJumpVerticalSpeed (jumpHeight)
				SendMessage("DidJump", SendMessageOptions.DontRequireReceiver)
	
	def ApplyGravity():
		if self.IsJumping() and not jumpingReachedApex and verticalSpeed <= 0.0:
			jumpingReachedApex = true
			SendMessage("DidJumpReachApex", SendMessageOptions.DontRequireReceiver)

		if IsGrounded():
			verticalSpeed = 0.0
		else:
			verticalSpeed -= gravity * Time.deltaTime
	
	def CalculateJumpVerticalSpeed (targetJumpHeight as single):
		// From the jump height and gravity we deduce the upwards speed 
		// for the character to reach at the apex.
		return Mathf.Sqrt(2 * targetJumpHeight * gravity)
	
	def DidJump():
		jumping = true
		jumpingReachedApex = false
		lastJumpTime = Time.time
		lastJumpStartHeight = transform.position.y
		lastJumpButtonTime = -10
		
		_characterState = CharacterState.Jumping
	
	def EndDamage():
		damaged = false
	
	def StartDamage():
		damaged = true
		attacking = false
		jumping = false
	
	def EndAttack():
		attacking = false
	
	def StartAttack():
		attacking = true
		startAttackingTime = Time.time
		middleOfAttack = false
	
	def JumpAction():
		return Input.GetButtonDown ("Jump")
	
	def MoveChar():
		
		movement = moveDirection * moveSpeed
		if(attacking and IsGrounded()):
			movement *= 0
		movement += Vector3 (0, verticalSpeed, 0)
		
		movement *= Time.deltaTime
		
		collisionFlags = _controller.Move(movement)
			
		// Set rotation to the move direction
		if not damaged:
			if IsGrounded():
				transform.rotation = Quaternion.LookRotation(moveDirection)
			else:
				xzMove = movement
				xzMove.y = 0
				if xzMove.sqrMagnitude > 0.001:
					transform.rotation = Quaternion.LookRotation(xzMove)
		
		// We are in jump mode but just became grounded
		if IsGrounded():
			lastGroundedTime = Time.time
			if self.IsJumping():
				jumping = false
				SendMessage("DidLand", SendMessageOptions.DontRequireReceiver)
	
	def UpdateAnimation():
		// ANIMATION sector
		if _animation:
			if _characterState == CharacterState.Hitted:
				_animation[onHitAnimation.name].speed = onHitAnimationSpeed
				_animation.CrossFade(onHitAnimation.name)
			elif _characterState == CharacterState.Attacking:
				_animation[attackAnimation.name].speed = attackAnimationSpeed
				_animation.CrossFade(attackAnimation.name)
			elif _characterState == CharacterState.Jumping:
				if not jumpingReachedApex:
					_animation[jumpPoseAnimation.name].speed = jumpAnimationSpeed
					_animation[jumpPoseAnimation.name].wrapMode = WrapMode.ClampForever
					_animation.CrossFade(jumpPoseAnimation.name)
				else:
					_animation[jumpPoseAnimation.name].speed = -landAnimationSpeed
					_animation[jumpPoseAnimation.name].wrapMode = WrapMode.ClampForever
					_animation.CrossFade(jumpPoseAnimation.name)
			elif _controller.velocity.sqrMagnitude < 0.1:
					_animation.CrossFade(idleAnimation.name)
			elif(_characterState == CharacterState.Walking):
					_animation[walkAnimation.name].speed = Mathf.Clamp(_controller.velocity.magnitude, 0.0, walkMaxAnimationSpeed)
					_animation.CrossFade(walkAnimation.name)
	
	virtual def GetATKRange():
		#TODO apagar essa merda depois
		return 0.0f
	virtual def DealDamage(lala as GenericChar):
		#TODO apagar essa merda depois
		return 0.0f
			
	def Action():
		if self.attacking:
			Debug.DrawRay(GetCharPosition(), moveDirection * self.GetATKRange(), Color.black, 0)
			raycasthit as RaycastHit
			
			Physics.Raycast(GetCharPosition(), moveDirection, raycasthit, self.GetATKRange())
			if raycasthit.collider != null:
				if raycasthit.collider.gameObject != null:
					if raycasthit.collider.gameObject.GetComponent("GenericChar") != null:
						char_controller as GenericChar = raycasthit.collider.gameObject.GetComponent("GenericChar")
						if char_controller != null:
							#TODO
							if not char_controller.damaged:
								self.DealDamage(char_controller)
	
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
		
		if not isControllable:
			// kill all inputs if not controllable.
			Input.ResetInputAxes()
	
		if self.IsJumping():
			lastJumpButtonTime = Time.time
		
		Action()
		
		UpdateAnimation()
	
	def OnAnotherControllerHit(hit as ControllerColliderHit):
		pass
	
	def OnControllerColliderHit(hit as	ControllerColliderHit):
		//char_controller = hit.gameObject.GetComponent("GenericCharController")
		//if(char_controller)
		//	self.OnAnotherControllerHit(hit)
		if hit.moveDirection.y > 0.01:
			return
	
	def GetWalkSpeed():
		return walkSpeed
	
	virtual def IsJumping():
		return jumping
	
	def IsGrounded():
		return (collisionFlags & CollisionFlags.CollidedBelow) != 0
	
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
