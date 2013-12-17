import UnityEngine

class MovingPlataform (MonoBehaviour): 

	public plataform as GameObject
	public speed as single = 1
	public distance as single = 5.0
	
	public direction as Vector3 = Vector3(1,0,0)
	private startPosition as Vector3
	
	def Start():
		startPosition = self.transform.position

	def FixedUpdate ():
		#plataform.rigidbody.angularVelocity = Vector3.zero
		#plataform.rigidbody.velocity = direction*speed
		self.transform.position = self.transform.position + speed*direction*Time.deltaTime
	
		if Vector3.Distance(startPosition, transform.position) > distance:
			self.speed = speed*-1
		
