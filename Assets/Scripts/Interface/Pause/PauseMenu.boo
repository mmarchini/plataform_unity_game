import UnityEngine

class PauseMenu(InterfaceElement): 
	
	DrawBox:
		get:
			return self.player.paused
	
	text as string:
		get:
			return """<color='black'>HP: $(player.CurrentHP)/$(player.MaxHP)
MP: $(player.CurrentMP)/$(player.MaxMP)
ATK: $(player.ATK)
DEF: $(player.DEF)
Spear: $(player.Spear*100)%
Shield: $(player.Shield*100)%
CritChance: $(player.CritChance*100)%
CritDamage: $(player.CritDamage)x

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

		
