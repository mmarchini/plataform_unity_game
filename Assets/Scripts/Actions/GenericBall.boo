import UnityEngine

class GenericBall (MonoBehaviour): 

	public startSpeed = 3.0f
	private currentSpeed = 0.0f
	public maxSpeed = 8.0f
	public aceleration = 1.0f
	[HideInInspector]
	public direction as Vector3
	public invokedBy as string
	public damage as single
	[HideInInspector]
	public char_controller as GenericChar
	
	private size = 1.3
	private startPoint = 1.1
	

	def Start ():
		currentSpeed = startSpeed
		
	def Update ():
		
		self.rigidbody.velocity = self.direction*self.currentSpeed
		if self.currentSpeed < self.maxSpeed:
			self.currentSpeed += self.aceleration*Time.deltaTime
		cc as GenericChar = self.Raycast(self.direction, self.size)
		
		if cc:
			cc.TakeDamage(self.char_controller, damage)
			Destroy(self.gameObject)
	

	def Raycast(direction as Vector3, range as single):
		ray = Ray(self.transform.position-Vector3(self.startPoint,0,0), direction)
		
		Debug.DrawRay(ray.origin, ray.direction*range, Color.black, 0)
		
		raycasthit as RaycastHit
		
		if Physics.Raycast(ray, raycasthit, range):
			if raycasthit.collider != null:
				if raycasthit.collider.gameObject != null and self.invokedBy != raycasthit.collider.gameObject.tag:
					if raycasthit.collider.gameObject.GetComponent("GenericChar") != null:
						cc as GenericChar = raycasthit.collider.gameObject.GetComponent("GenericChar")
						if cc != null:
							return cc
		return null