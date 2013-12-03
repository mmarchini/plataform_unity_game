import UnityEngine

class WildTornadoRotate (MonoBehaviour): 

	public RotateSpeed as single=10.0f;
	
	def Update ():
		self.transform.Rotate(0, self.RotateSpeed, 0)
