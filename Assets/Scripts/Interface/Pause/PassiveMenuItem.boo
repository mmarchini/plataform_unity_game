﻿import UnityEngine

class PassiveMenuItem(InterfaceElement): 
	
	public passive as Passive
	
	description as PassiveMenuDescription
	lastClickButton = -1.0f
	
	private position = -2
	
	DrawBox:
		get:
			return self.player.paused
	
	text as string:
		get:
			return "<color='"+(self.position==0 and "yellow" or "white")+"'>$(self.passive.label)"+$(self.position==0 and " ($(self.passive.Level))" or "")+"</color>"
	
	Y:
		get:
			return super.Y + self.position*(self.H*1.3)
	
	def DrawItem(position as int):
		self.position = position
		if self.position == 0:
			self.description.DrawInterfaceElement()
		self.DrawInterfaceElement()
	
	def LevelUp():
		if self.player.Level > self.player.passivePoints and ( self.passive.MaxLevel < 0 or self.passive.Level < self.passive.MaxLevel) and (Time.realtimeSinceStartup-self.lastClickButton	 > 0.1f):
			self.passive.Level += 1
			self.lastClickButton = Time.realtimeSinceStartup
			
	def Awake():
		super.Awake()
		self.x = 7
		self.y = 45
		self.width = 31
		self.height = 7
		self.FontSize = 5
		self.TextX = 1
		self.TextY= 1.1
		self.texture = Resources.Load("$(self.gui_path)/Label") as Texture
		
		self.description = self.gameObject.AddComponent("PassiveMenuDescription")
		self.description.passive_item = self
