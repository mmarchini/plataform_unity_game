import UnityEngine

class RotateCamera (MonoBehaviour): 

	public RotateSpeed as single=1.0f;
	
	def Update ():
		self.transform.Rotate(0, self.RotateSpeed, 0)
