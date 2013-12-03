import UnityEngine


class EnemyHP (MonoBehaviour): 

	private char_controller as Enemy
	[HideInInspector]
	public forward as Vector3
	private text as TextMesh
	
	
	def Start():
		self.char_controller = self.transform.parent.GetComponent("Enemy")
		self.text = self.GetComponent("TextMesh")
		self.text.characterSize = 0.5
		if not self.char_controller:
			Debug.Log("Oops.")
			Destroy(self)
	
	def Update():
		self.transform.forward = self.forward
		self.text.text = "$(self.char_controller.CurrentHP)"
