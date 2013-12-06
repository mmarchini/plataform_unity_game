import UnityEngine

class MovingPlataform (MonoBehaviour): 

	public plataform as GameObject
	public speed as single = 1
	
	public direction as Vector3 = Vector3(1,0,0)

	def FixedUpdate ():
		plataform.rigidbody.angularVelocity = Vector3.zero
		plataform.rigidbody.velocity = direction*speed
	
	def OnTriggerExit(collider as Collider):
		if collider.gameObject == plataform:
			self.speed = speed*-1
		
