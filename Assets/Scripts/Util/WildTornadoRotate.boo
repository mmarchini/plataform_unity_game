import UnityEngine

class WildTornadoRotate (MonoBehaviour): 

	public RotateSpeed as Vector3;
	
	def Update ():
		self.transform.Rotate(self.RotateSpeed)
