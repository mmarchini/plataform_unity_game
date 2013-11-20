﻿import UnityEngine
import CurrentSkill

class Player (GenericChar): 

	public attackClip as AudioClip

	public SelOrbs as List = ["Wind", "Fire", "Water"]

	private _paused = false

	paused:
		get:
			return _paused
		set:
			_paused = value

	def Awake():
		self.passive_controller = self.GetComponent("PassiveController")
		self.skill_controller = self.GetComponent("SkillController")
		self.buff_controller = self.GetComponent("BuffController")
		self.passive_controller.generic_char = self
		super.Awake()

	def GetHorizontalSpeed():
		if damaged:
			return 0
		return Input.GetAxisRaw("Horizontal")
	
	def Update():
		if Input.GetButtonDown("Fire"):
			self.SelOrbs = ["Fire"] + self.SelOrbs[:-1]
		if Input.GetButtonDown("Water"):
			self.SelOrbs = ["Water"] + self.SelOrbs[:-1]
		if Input.GetButtonDown("Wind"):
			self.SelOrbs = ["Wind"] + self.SelOrbs[:-1]
		if Input.GetButtonDown("Skill"):
			if self.skill_controller:
				self.skill_controller.Execute(self, GetCurrentSkill(self))
			
		super.Update()
	
	JumpAction:
		get:
			return Input.GetButtonDown ("Jump")

	def StartAttack():
		if not self.attacking:
				super.StartAction()
				(self.GetComponent("AudioSource") as AudioSource).PlayOneShot(self.attackClip, 1.0)
	
	def ExecuteAttack():
		return Input.GetButtonDown ("Attack") and not damaged