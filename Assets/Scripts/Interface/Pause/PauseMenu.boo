import UnityEngine

class PauseMenu(InterfaceElement): 
	
	DrawBox:
		get:
			return self.player.paused
	
	text as string:
		get:
			max_HP = player.GetCharAttribute("HP")
			max_MP = player.GetCharAttribute("MP")
			ATK = player.GetCharAttribute("ATK")
			DEF = player.GetCharAttribute("DEF")
			Spear = player.GetCharAttribute("Spear")
			Shield = player.GetCharAttribute("Shield")
			CritChance = player.GetCharAttribute("CritChance")
			CritDamage = player.GetCharAttribute("CritDamage")
			return """<color='black'>HP: $(player.CurrentHP)/$(max_HP))
MP: $(player.CurrentMP)/$(max_MP)
ATK: $(ATK)
DEF: $(DEF)
Spear: $(Spear*100)%
Shield: $(Shield*100)%
CritChance: $(CritChance*100)%
CritDamage: $(CritDamage)x

Botao de Ataque: Passive Menu
</color>"""
	
	
	def Awake():
		super.Awake()
		self.x = 0
		self.y = 15
		self.width = 75
		self.height = 95
		self.FontSize = 5
		self.TextX = 0
		self.TextY= 1

		
