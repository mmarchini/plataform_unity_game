﻿import UnityEngine

class Buff (MonoBehaviour): 

	public label as string
	public description as string
	public time = -1
	
	public HPSec = 0
	public MinHP = 0.10
	public MPSec = 0
	public MinMP = 0.05
	
	[HideInInspector]
	public current_time = -10
	protected destroy = false
	[HideInInspector]
	public affected_attributes = []
	protected char_controller as GenericChar
	
	effect as GameObject
	
	virtual def Effect(caller as string) as single:
		return 0.0
	
	def Start():
		self.Reset()
		self.char_controller = self.GetComponent("GenericChar")
		a = Resources.Load("Effects/$(self.label)", GameObject) as GameObject
		if a:
			go as GameObject = Instantiate(a)
			go.transform.parent = self.gameObject.transform
			go.transform.localPosition = Vector3(0,self.char_controller.height/2,0)
			go.transform.localScale = Vector3(0.4,0.4,0.4)
			self.effect = go
		
		self.InvokeRepeating("LostEverySeconds", 1, 1)


	def Update():
		if (self.time >= 0 and Time.time - self.current_time > time) or self.destroy:
			Destroy(self)
	
	virtual def Reset():
		self.current_time = Time.time
		self.destroy = false

	def OnDestroy():
		if self.effect:
			Destroy(self.effect)
		
	def LostEverySeconds():
		
		self.char_controller.LostHP += self.HPSec
		self.char_controller.LostMP += self.MPSec
		
		if self.char_controller.CurrentHP <= self.char_controller.GetCharAttribute("HP")*0.10:
			Destroy(self)	
		if self.char_controller.CurrentMP <= self.char_controller.GetCharAttribute("MP")*0.05:
			Destroy(self)
