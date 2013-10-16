// Require a character controller to be attached to the same game object
@script RequireComponent(CharacterController)

public var idleAnimation : AnimationClip;
public var walkAnimation : AnimationClip;
public var attackAnimation : AnimationClip;
public var jumpPoseAnimation : AnimationClip;

public var walkMaxAnimationSpeed : float = 0.75;
public var jumpAnimationSpeed : float = 1.15;
public var attackAnimationSpeed : float = 1.15;
public var landAnimationSpeed : float = 1.0;

private var _animation : Animation;

private var _controller : CharacterController;

enum CharacterState {
	Idle = 0,
	Walking = 1,
	Jumping = 2,
	Attacking = 3,
}

private var _characterState : CharacterState;

// The speed when walking
var walkSpeed = 4.0;

var inAirControlAcceleration = 3.0;

// How high do we jump when pressing jump and letting go immediately
var jumpHeight = 0.5;

// The gravity for the character
var gravity = 25.0;
// The gravity in controlled descent mode
var speedSmoothing = 70.0;
var rotateSpeed = 5000.0;

var canJump = true;

private var jumpRepeatTime = 0.05;
private var jumpTimeout = 0.15;
private var groundedTimeout = 0.25;

// The camera doesnt start following the target immediately but waits for a split second to avoid too much waving around.
private var lockCameraTimer = 0.0;

// The current move direction in x-z
private var moveDirection = Vector3.zero;
// The current vertical speed
private var verticalSpeed = 0.0;
// The current x-z move speed
private var moveSpeed = 0.0;

// The last collision flags returned from controller.Move
private var collisionFlags : CollisionFlags; 

// Are we jumping? (Initiated with jump button and not grounded yet)
protected var jumping = false;
private var jumpingReachedApex = false;

protected var attacking = false;

// Is the user pressing any keys?
private var isMoving = false;
// Last time the jump button was clicked down
private var lastJumpButtonTime = -10.0;
// Last time we performed a jump
private var lastJumpTime = -1.0;

// the height we jumped from (Used to determine for how long to apply extra jump power after jumping.)
private var lastJumpStartHeight = 0.0;


private var inAirVelocity = Vector3.zero;

private var lastGroundedTime = 0.0;


private var isControllable = true;

function Awake ()
{
	moveDirection = transform.TransformDirection(Vector3.forward);
	
	_animation = GetComponent(Animation);
	_controller = GetComponent(CharacterController);
	if(!_animation)
		Debug.Log("The character you would like to control doesn't have animations. Moving her might look weird.");
	
	if(!idleAnimation) {
		_animation = null;
		Debug.Log("No idle animation found. Turning off animations.");
	}
	if(!walkAnimation) {
		_animation = null;
		Debug.Log("No walk animation found. Turning off animations.");
	}
	if(!jumpPoseAnimation && canJump) {
		_animation = null;
		Debug.Log("No jump animation found and the character has canJump enabled. Turning off animations.");
	}
	
	event = AnimationEvent();
	event.functionName = "EndAttack";
	event.time = attackAnimation.length-0.1f;
	attackAnimation.AddEvent(event);
			
}

function getHorizontalSpeed(){
	return Input.GetAxisRaw("Horizontal");
}

function GetRightVector(){
	var cameraTransform = Camera.main.transform;
		
	// Forward vector relative to the camera along the x-z plane	
	var forward = cameraTransform.TransformDirection(Vector3.forward);
	forward.y = 0;
	forward = forward.normalized;

	// Right vector relative to the camera
	// Always orthogonal to the forward vector
	var right = Vector3(forward.z, 0, -forward.x);
	
	return right;
}

function UpdateSmoothedMovementDirection ()
{
	var grounded = IsGrounded();
	
	var right = GetRightVector();

	var h = this.GetHorizontalSpeed();

	var wasMoving = isMoving;
	isMoving = Mathf.Abs (h) > 0.1;
		
	// Target direction relative to the camera
	var targetDirection = h * right;
	
	// Grounded controls
	if (grounded)
	{
		// Lock camera for short period when transitioning moving & standing still
		lockCameraTimer += Time.deltaTime;
		if (isMoving != wasMoving)
			lockCameraTimer = 0.0;

		// We store speed and direction seperately,
		// so that when the character stands still we still have a valid forward direction
		// moveDirection is always normalized, and we only update it if there is user input.
		if (targetDirection != Vector3.zero)
		{
			// If we are really slow, just snap to the target direction
			if (moveSpeed < this.GetWalkSpeed() * 0.9 && grounded)
			{
				moveDirection = targetDirection.normalized;
			}
			// Otherwise smoothly turn towards it
			else
			{
				moveDirection = Vector3.RotateTowards(moveDirection, targetDirection, rotateSpeed * Mathf.Deg2Rad * Time.deltaTime, 1000);
				
				moveDirection = moveDirection.normalized;
			}
		}
		
		// Smooth the speed based on the current target direction
		var curSmooth = speedSmoothing * Time.deltaTime;
		
		// Choose target speed
		//* We want to support analog input but make sure you cant walk faster diagonally than just forward or sideways
		var targetSpeed = Mathf.Min(targetDirection.magnitude, 1.0);
	
		targetSpeed *= this.GetWalkSpeed();
		_characterState = CharacterState.Walking;
				
		moveSpeed = Mathf.Lerp(moveSpeed, targetSpeed, curSmooth);
		
	}
	// In air controls
	else
	{
		// Lock camera while in air
		if (this.IsJumping())
			lockCameraTimer = 0.0;

		if (isMoving)
			inAirVelocity += targetDirection.normalized * Time.deltaTime * inAirControlAcceleration;
	}
	

		
}

function ApplyAttack ()
{
	if (isControllable)	// don't move player at all if not controllable.
	{
		// When we reach the apex of the jump we send out a message
		if (this.ExecuteAttack())
		{
			this.StartAttack();
		}
		if(attacking){
			_characterState = CharacterState.Attacking;
		}
	}
}

function ApplyJumping ()
{
	// Prevent jumping too fast after each other
	if (lastJumpTime + jumpRepeatTime > Time.time)
		return;

	if (IsGrounded()) {
		// Jump
		// - Only when pressing the button down
		// - With a timeout so you can press the button slightly before landing		
		if (canJump && Time.time < lastJumpButtonTime + jumpTimeout) {
			verticalSpeed = CalculateJumpVerticalSpeed (jumpHeight);
			SendMessage("DidJump", SendMessageOptions.DontRequireReceiver);
		}
	}
}

function ApplyGravity ()
{
	if (isControllable)	// don't move player at all if not controllable.
	{
		// When we reach the apex of the jump we send out a message
		if (this.IsJumping() && !jumpingReachedApex && verticalSpeed <= 0.0)
		{
			jumpingReachedApex = true;
			SendMessage("DidJumpReachApex", SendMessageOptions.DontRequireReceiver);
		}
	
		if (IsGrounded ())
			verticalSpeed = 0.0;
		else
			verticalSpeed -= gravity * Time.deltaTime;
	}
}

function CalculateJumpVerticalSpeed (targetJumpHeight : float)
{
	// From the jump height and gravity we deduce the upwards speed 
	// for the character to reach at the apex.
	return Mathf.Sqrt(2 * targetJumpHeight * gravity);
}

function DidJump ()
{
	jumping = true;
	jumpingReachedApex = false;
	lastJumpTime = Time.time;
	lastJumpStartHeight = transform.position.y;
	lastJumpButtonTime = -10;
	
	_characterState = CharacterState.Jumping;
}

function EndAttack (){
	attacking = false;
}

function StartAttack ()
{
	attacking = true;
}

function JumpAction(){
	return Input.GetButtonDown ("Jump");
}

function MoveChar(){
	// Calculate actual motion
	if(attacking && IsGrounded()){
		moveSpeed = 0;
	}
	
	var movement = moveDirection * moveSpeed + Vector3 (0, verticalSpeed, 0) + inAirVelocity;
	movement *= Time.deltaTime;
	
	collisionFlags = _controller.Move(movement);
	
		// Set rotation to the move direction
	if (IsGrounded())
	{
		transform.rotation = Quaternion.LookRotation(moveDirection);
			
	}	
	else
	{
		var xzMove = movement;
		xzMove.y = 0;
		if (xzMove.sqrMagnitude > 0.001)
		{
			transform.rotation = Quaternion.LookRotation(xzMove);
		}
	}
	
	// We are in jump mode but just became grounded
	if (IsGrounded())
	{
		lastGroundedTime = Time.time;
		inAirVelocity = Vector3.zero;
		if (this.IsJumping())
		{
			jumping = false;
			SendMessage("DidLand", SendMessageOptions.DontRequireReceiver);
		}
	}
}

function UpdateAnimation(){
	// ANIMATION sector
	if(_animation) {
		if(_characterState == CharacterState.Attacking) {
			_animation[attackAnimation.name].speed = attackAnimationSpeed;
			_animation.CrossFade(attackAnimation.name);
		} else if(_characterState == CharacterState.Jumping) 
		{
			if(!jumpingReachedApex) {
				_animation[jumpPoseAnimation.name].speed = jumpAnimationSpeed;
				_animation[jumpPoseAnimation.name].wrapMode = WrapMode.ClampForever;
				_animation.CrossFade(jumpPoseAnimation.name);
			} else {
				_animation[jumpPoseAnimation.name].speed = -landAnimationSpeed;
				_animation[jumpPoseAnimation.name].wrapMode = WrapMode.ClampForever;
				_animation.CrossFade(jumpPoseAnimation.name);				
			}
		} 
		else 
		{
			if(_controller.velocity.sqrMagnitude < 0.1) {
				_animation.CrossFade(idleAnimation.name);
			}
			else if(_characterState == CharacterState.Walking) {
					_animation[walkAnimation.name].speed = Mathf.Clamp(_controller.velocity.magnitude, 0.0, walkMaxAnimationSpeed);
					_animation.CrossFade(walkAnimation.name);	
			}
		}
	}
	// ANIMATION sector

}

function Action(){
	

	UpdateSmoothedMovementDirection();

	// Apply gravity
	// - extra power jump modifies gravity
	// - controlledDescent mode modifies gravity
	ApplyGravity();
	
	// Apply jumping logic
	ApplyJumping();
	
	MoveChar();
	
	
	ApplyAttack();
}

function Update() {
	
	if (!isControllable) {
		// kill all inputs if not controllable.
		Input.ResetInputAxes();
	}

	if (this.IsJumping()) {
		lastJumpButtonTime = Time.time;
	}
	
	Action();
	
	UpdateAnimation();
}

function OnAnotherControllerHit(hit : ControllerColliderHit){
	
}

function OnControllerColliderHit (hit : ControllerColliderHit )
{
	char_controller = hit.gameObject.GetComponent("GenericCharController");
	if(char_controller)
		this.OnAnotherControllerHit(hit);
	if (hit.moveDirection.y > 0.01) 
		return;
}

function GetSpeed () {
	return moveSpeed;
}

function GetWalkSpeed () {
	return walkSpeed;
}

function IsJumping () {
	return jumping;
}

function IsGrounded () {
	return (collisionFlags & CollisionFlags.CollidedBelow) != 0;
}

function GetDirection () {
	return moveDirection;
}

function GetLockCameraTimer () 
{
	return lockCameraTimer;
}

function IsMoving ()  : boolean
{
	return Mathf.Abs(Input.GetAxisRaw("Horizontal")) > 0.5;
}

function HasJumpReachedApex ()
{
	return jumpingReachedApex;
}

function IsGroundedWithTimeout ()
{
	return lastGroundedTime + groundedTimeout > Time.time;
}

function ExecuteAttack(){
	return false;
}

function Reset ()
{
	gameObject.tag = "Player";
}
