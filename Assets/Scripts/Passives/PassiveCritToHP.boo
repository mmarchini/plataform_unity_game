
class PassiveCritToHP (Passive): 

	def Awake():
		self.label = "Crit To HP"
		self.description = """
Aumenta o Dano ao custo de HP:
$(self.PerLevel*100)% x level da passiva
"""
		self.PerLevel = 0.01
		self.MaxLevel = 5
		self.affects = "DMG"
	
		self.required_passives = {}
		
	virtual def Effect(player as Player):
		player.LostHP -= player.GetCharAttribute("ATK")*player.GetCharAttribute("CritDamage") +  player.SpearATK
		return 0.0
