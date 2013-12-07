import UnityEngine

class ChangeScene (MonoBehaviour): 
	
	public scene as string


	def ChangeScene():
		if scene:
			Application.LoadLevel(scene)
		else:
			Debug.Log("No scene name!")
		
	def OnPlayerHit():
		Camera.mainCamera.GetComponent(CameraFade).FadeOut()
		self.Invoke("ChangeScene", 0.3)
		