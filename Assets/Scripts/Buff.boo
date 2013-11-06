import UnityEngine

class Buff (MonoBehaviour): 

	label as string
	description as string
	
	virtual def Effect() as single:
		return 0.0
		
	