import UnityEngine 
import UnityEditor


class Gift(System.Object): 
	public Map as string
	public Gift as (string)
	
class NextMap(System.Object):
	public lastMap as string
	public nextMap as string

class GetGift (ChangeScene): 
	
	public tresureBox as GameObject
	opened = false
	public openAnimation as AnimationClip
	public giftsPerMap as (Gift)  
	public nextMap as (NextMap)
	
	gifts:
		get:
			for g in giftsPerMap:
				if g.Map == scene:
					return g.Gift
			return []
	
	def ChangeScene():
		if scene:
			for nm in nextMap:
				if nm.lastMap == scene:
					Application.LoadLevel(nm.nextMap)
		else:
			Debug.Log("No scene name!")

	def Gift():
		player as GameObject = GameObject.FindGameObjectWithTag("Player")
		passive_controller = player.GetComponent(PassiveController)
		if passive_controller:
			
			for gift in self.gifts:
				ConditionalController.SatisfyClause("Gift$(gift)")
				passive_controller.AddPassive(gift)

	def FadeOut():
		Camera.mainCamera.GetComponent(CameraFade).FadeOut() 
		self.Gift()
		self.Invoke("ChangeScene", 0.3)


	def OnPlayerHit():
		if tresureBox:
			if not opened:
				tresureBox.animation.Play(openAnimation.name)
				self.Invoke("FadeOut", 1.3)
				opened = true
		elif not opened:
			self.FadeOut()
			opened = true
			