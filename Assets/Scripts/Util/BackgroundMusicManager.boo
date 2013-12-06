import UnityEngine

class BackgroundMusicManager (MonoBehaviour): 


	def GetMapMusic():
		bmlist = self.GetComponentsInChildren(BackgroundMusic)
		audio as AudioSource = self.GetComponent(AudioSource)
		
		if bmlist:
			for bm as BackgroundMusic in bmlist:
				if Application.loadedLevelName in bm.maps:
					if audio.clip != bm.clip:
						audio.Stop()
						audio.clip = bm.clip
						audio.Play()
					break


	def Awake():
		self.GetMapMusic()
		
	def OnLevelWasLoaded(level):
		self.GetMapMusic()
		
