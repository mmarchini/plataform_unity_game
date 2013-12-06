import UnityEngine

class Plataform (MonoBehaviour): 

	original_parent as Transform
	
	def OnTriggerEnter(collider as Collider):
		if collider.tag == "Player":
			if collider.transform.parent != self.transform.parent:
				self.original_parent = collider.transform.parent
				collider.transform.parent = self.transform.parent
				
	def OnTriggerExit(collider as Collider):
		if collider.tag == "Player":
			collider.transform.parent = self.original_parent
	
	def OnTriggerStay(collider as Collider):
		if collider.tag == "Player":
			if (collider.gameObject.GetComponent("Player") as Player).verticalSpeed < 0:
				(collider.gameObject.GetComponent("Player") as Player).verticalSpeed = 0
