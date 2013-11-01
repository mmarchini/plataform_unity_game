import UnityEngine

class ThirdPersonCamera(MonoBehaviour): 
	public cameraTransform as Transform
	_target as Transform
	
	// The distance in the x-z plane to the target
	
	public distance = 7.0
	
	// the height we want the camera to be above the target
	public height = 1.5
	
	public angularSmoothLag = 0.3
	public angularMaxSpeed = 15.0
	
	public heightSmoothLag = 0.0
	
	public clampHeadPositionScreenSpace = 0.75
	
	public lockCameraTimeout = 0.2
	
	private headOffset = Vector3.zero
	private centerOffset = Vector3.zero
	
	heightVelocity = 0.0f
	angleVelocity = 0.0f
	controller as GenericCharController
	targetHeight = 100000.0 
		
	def Awake():
		if not cameraTransform and Camera.main:
			cameraTransform = Camera.main.transform
		if not cameraTransform:
			Debug.Log("Please assign a camera to the ThirdPersonCamera script.")
			enabled = false	

		_target = transform
		if _target:
			controller = _target.GetComponent("GenericCharController")
		
		if controller:
			characterController as CharacterController = _target.collider
			centerOffset = characterController.bounds.center - _target.position
			headOffset = centerOffset
			headOffset.y = characterController.bounds.max.y - _target.position.y
		else:
			Debug.Log("Please assign a target to the camera that has a GenericCharController script attached.")
	
		Cut(_target, centerOffset)
	
	def AngleDistance(a as single, b as single):
		a = Mathf.Repeat(a, 360)
		b = Mathf.Repeat(b, 360)
		
		return Mathf.Abs(b - a)
	
	def Apply(dummyTarget as Transform, dummyCenter as Vector3):
		// Early out if we don't have a target
		if not controller:
			return
		
		targetCenter = _target.position + centerOffset
		
		// Calculate the current & target rotation angles
		originalTargetAngle = _target.eulerAngles.y
		currentAngle = cameraTransform.eulerAngles.y
	
		// Adjust real target angle when camera is locked
		targetAngle = originalTargetAngle 
		
		
		//if (controller.GetLockCameraTimer () < lockCameraTimeout)
		//{
		//	targetAngle = currentAngle
		//}
	
		currentAngle = Mathf.SmoothDampAngle(currentAngle, targetAngle, angleVelocity, angularSmoothLag, angularMaxSpeed)
		
		targetHeight = targetCenter.y + height
	
		// Damp the height
		currentHeight = cameraTransform.position.y
		currentHeight = Mathf.SmoothDamp (currentHeight, targetHeight, heightVelocity, heightSmoothLag)
	
		// Convert the angle into a rotation, by which we then reposition the camera
		currentRotation = Quaternion.Euler (0, currentAngle, 0)
		
		// Set the position of the camera on the x-z plane to:
		// distance meters behind the target
		cameraTransform.position = targetCenter
		cameraTransform.position += currentRotation * Vector3.back * distance
	
		// Set the height of the camera
		cameraTransform.position.y = currentHeight
		
		// Always look at the target	
		//SetUpRotation(targetCenter, targetHead)
	
	def LateUpdate():
		Apply (transform, Vector3.zero)
	
	def Cut(dummyTarget as Transform, dummyCenter as Vector3):
		oldHeightSmooth = heightSmoothLag
		
		heightSmoothLag = 0.001
		
		Apply (transform, Vector3.zero)
		
		heightSmoothLag = oldHeightSmooth
	
	def SetUpRotation(centerPos as Vector3, headPos as Vector3):
		// Now it's getting hairy. The devil is in the details here, the big issue is jumping of course.
		// * When jumping up and down we don't want to center the guy in screen space.
		//  self is important to give a feel for how high you jump and avoiding large camera movements.
		//   
		// * At the same time we dont want him to ever go out of screen and we want all rotations to be totally smooth.
		//
		// So here is what we will do:
		//
		// 1. We first find the rotation around the y axis. Thus he is always centered on the y-axis
		// 2. When grounded we make him be centered
		// 3. When jumping we keep the camera rotation but rotate the camera to get him back into view if his head is above some threshold
		// 4. When landing we smoothly interpolate towards centering him on screen
		cameraPos = cameraTransform.position
		offsetToCenter = centerPos - cameraPos
		
		// Generate base rotation only around y-axis
		yRotation = Quaternion.LookRotation(Vector3(offsetToCenter.x, 0, offsetToCenter.z))
	
		relativeOffset = Vector3.forward * distance + Vector3.down * height
		cameraTransform.rotation = yRotation * Quaternion.LookRotation(relativeOffset)
	
		// Calculate the projected center position and top position in world space
		centerRay = cameraTransform.camera.ViewportPointToRay(Vector3(.5, 0.5, 1))
		topRay = cameraTransform.camera.ViewportPointToRay(Vector3(.5, clampHeadPositionScreenSpace, 1))
	
		centerRayPos = centerRay.GetPoint(distance)
		topRayPos = topRay.GetPoint(distance)
		
		centerToTopAngle = Vector3.Angle(centerRay.direction, topRay.direction)
		
		heightToAngle = centerToTopAngle / (centerRayPos.y - topRayPos.y)
	
		extraLookAngle = heightToAngle * (centerRayPos.y - centerPos.y)
		if extraLookAngle < centerToTopAngle:
			extraLookAngle = 0
		else:
			extraLookAngle = extraLookAngle - centerToTopAngle
			cameraTransform.rotation *= Quaternion.Euler(-extraLookAngle, 0, 0)
	
	def GetCenterOffset ():
		return centerOffset
