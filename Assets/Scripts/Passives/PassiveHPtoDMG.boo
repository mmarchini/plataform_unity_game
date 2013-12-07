import UnityEngine

class PassiveHPtoDMG (Passive): 
	
	def Awake():
		self.label = "HP to DMG"
		self.description = """
Aumenta o Dano ao custo de HP:
$(self.PerLevel*100)% x level da passiva
"""
		self.PerLevel = 0.01
		self.MaxLevel = 5
		self.affects = "DMG"
	
		self.required_passives = {}
		
	def Effect(player as Player):
		Debug.Log("Allonz-y")
		if player.CurrentHP/player.GetCharAttribute("HP") > self.PerLevel*self.Level:
			HP = self.Level*self.PerLevel*player.GetCharAttribute("HP")
			player.LostHP += HP
			return HP
		return 0.0
