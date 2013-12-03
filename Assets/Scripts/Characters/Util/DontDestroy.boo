import UnityEngine

class DontDestroy (MonoBehaviour): 

	def Start ():
		DontDestroyOnLoad(self.gameObject)
		Destroy(self)