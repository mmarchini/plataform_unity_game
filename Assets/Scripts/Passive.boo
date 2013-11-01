import UnityEngine

class Passive (MonoBehaviour):
	
	label = ""
	
	public Level as int = 0
	public PerLevel as single = 0.0f
	required_passives = {"":0}
	affects as string
	AffectAttribute:
		get:
			return self.affects
	
	virtual def Effect(player as Player):
		return player.Level*self.Level*self.PerLevel
		