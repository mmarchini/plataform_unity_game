#@script RequireComponent(CharacterController);

import UnityEngine

enum CharacterState:
	Idle = 0
	Walking = 1
	Jumping = 2
	Action = 3

class GenericCharController(MonoBehaviour): 
	public action_controller as ActionController
	
	public idleAnimation as AnimationClip
	public walkAnimation as AnimationClip
	public jumpPoseAnimation as AnimationClip
	
	public walkMaxAnimationSpeed  = 0.75f
	public jumpAnimationSpeed  = 1.15f

	// How high do we jump when pressing jump and letting go immediately
	public jumpHeight = 0.5
	
	// The gravity for the character
	public gravity = 25.0
			
	protected _animation as Animation
	protected _controller as CharacterController
	
	private jumpRepeatTime = 0.05
	private jumpTimeout = 0.15
	
	// The current vertical speed
	private verticalSpeed = 0.0
	
	// Are we jumping? (Initiated with jump button and not grounded yet)
	protected _jumping = false
	
	protected attacking = false
	
	def Awake():
		_animation = GetComponent(Animation)
		_controller = GetComponent(CharacterController) 
		self.action_controller = self.GetComponent("ActionController")
		if not _animation:
			Debug.Log("The character you would like to control doesn't have animations. Moving her might look weird.")
		if not idleAnimation:
			_animation = null
			Debug.Log("No idle animation found. Turning off animations.")
		if not walkAnimation:
			_animation = null
			Debug.Log("No walk animation found. Turning off animations.")
		if not jumpPoseAnimation:
			_animation = null
			Debug.Log("No jump animation found and the character has canJump enabled. Turning off animations.")
			
	currentAction as Action:
		get:
			for _action as Action in self.GetComponents(Action):
				if _action.enabled:
					return _action
			return null

	rightVector:
		get:
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
			if self.horizontalSpeed:
				return self.horizontalSpeed * self.rightVector
			else:
				return self.transform.forward.normalized
	
	moveDirection:
		get:
			_moveDirection as Vector3
			if targetDirection != Vector3.zero and not (_characterState==CharacterState.Action):
				_moveDirection = targetDirection.normalized
			else:
				_moveDirection = self.transform.forward
			
			return _moveDirection.normalized
	
	moveSpeed:
		get:
			if self.currentAction and Grounded or horizontalSpeed == 0:
				return 0
			if self.currentAction: 
				return self.currentAction.char_speed 
				
			if Mathf.Abs(horizontalSpeed) > 5.5:
				return 6.5
			if Mathf.Abs(horizontalSpeed) < 3 and horizontalSpeed != 0:
				return 3
			return Mathf.Abs(Mathf.Min(targetDirection.magnitude, 1.0) * horizontalSpeed)
	
	_characterState:
		get:
			if self.currentAction:
				return CharacterState.Action
			elif Jumping:
				return CharacterState.Jumping
			elif moveSpeed != 0:
				return CharacterState.Walking
			else:
				return CharacterState.Idle
	
	def ApplyJumping():
		if Grounded and Jumping:
			// Jump
			// - Only when pressing the button down
			// - With a timeout so you can press the button slightly before landing		
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
	
	virtual def StartAction():
		attacking = true
	
	virtual def EndAction():
		attacking = false
		
	virtual JumpAction:
		get:
			return false
	
	def MoveChar():
		movement = moveDirection * moveSpeed
		if(attacking and Grounded):
			movement *= 0
		movement += Vector3 (0, verticalSpeed, 0)
		
		movement *= Time.deltaTime
		
		_controller.Move(movement)
		
		// Set rotation to the move direction
		if not self.currentAction:
			if Grounded:
				transform.rotation = Quaternion.LookRotation(moveDirection)
			else:
				xzMove = movement
				xzMove.y = 0
				if xzMove.sqrMagnitude > 0.001:
					transform.rotation = Quaternion.LookRotation(xzMove)
		
		// We are in jump mode but just became grounded
		if Grounded:
			if Jumping:
				_jumping = false
				SendMessage("DidLand", SendMessageOptions.DontRequireReceiver)
	
	def UpdateAnimation():
		// ANIMATION sector
		if _animation:
			if _characterState == CharacterState.Action:
				if not _animation.IsPlaying(self.currentAction._animation.name):
					_animation[self.currentAction._animation.name].speed = self.currentAction.animationSpeed
					_animation.Play(self.currentAction._animation.name)
			elif _characterState == CharacterState.Jumping:
				_animation[jumpPoseAnimation.name].speed = jumpAnimationSpeed
				#_animation[jumpPoseAnimation.name].wrapMode = WrapMode.ClampForever
				_animation.CrossFade(jumpPoseAnimation.name)
			elif(_characterState == CharacterState.Walking):
				_animation[walkAnimation.name].speed = Mathf.Clamp(_controller.velocity.magnitude, 0.0, walkMaxAnimationSpeed)
				_animation.CrossFade(walkAnimation.name)
			elif(_characterState == CharacterState.Idle):
				_animation.CrossFade(idleAnimation.name)
				
	def ApplyAction():
		pass
	
	def Apply():
		
		// Apply gravity
		ApplyGravity()
		
		// Apply jumping logic
		ApplyJumping()
		
		MoveChar()
		
		ApplyAction()
	
	def GetCharPosition():
		return Vector3(self.gameObject.transform.position.x,self.gameObject.transform.position.y+0.7,self.gameObject.transform.position.z)
	
	virtual def Control():
		pass
	
	def Update():
		
		Control()
		
		Apply()
		
		UpdateAnimation()
	
	def OnControllerColliderHit(hit as	ControllerColliderHit):
		if hit.moveDirection.y > 0.01:
			return
	
	Jumping:
		get:
			if self.JumpAction:
				return true
			elif _jumping:
				return true
			else:
				return false
	Grounded:
		get:
 	 		return (not self._jumping) or (self._controller.isGrounded)
	
	virtual horizontalSpeed:
		get:
			return 0
	
	def Reset ():
		gameObject.tag = "Player"
