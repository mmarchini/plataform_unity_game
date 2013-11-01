﻿import UnityEngine

class PassiveATK (Passive): 
	
	def Awake():
		self.label = "Aumenta Ataque"
		self.description = """
Aumenta o ATK ganho por level em: 
$(self.PerLevel) x level da passiva
"""
		self.affects = "ATK"
	
		self.required_passives = {}
	