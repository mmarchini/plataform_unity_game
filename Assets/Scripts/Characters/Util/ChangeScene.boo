import UnityEngine

class ChangeScene (MonoBehaviour): 
	public scene as string
	
	def OnPlayerHit():
		if scene:
			Application.LoadLevel(scene)

	def Start ():
		pass
