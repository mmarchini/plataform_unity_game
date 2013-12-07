import UnityEngine

class Passive (MonoBehaviour):
	
	public label = "Passiva"
	public description = """Essa eh a classe base
para habilidades passivas.
Favor extende-la caso queira
criar uma nova habilidade passiva.
	"""
	
	public Level as int = 0
	public MaxLevel as int = 10
	public PerLevel as single = 0.0f
	required_passives = {"":0}
	affects as string
	AffectAttribute:
		get:
			return self.affects
	
	virtual def Effect(player as Player):
		return player.Level*self.Level*self.PerLevel
	
