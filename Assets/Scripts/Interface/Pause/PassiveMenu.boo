import UnityEngine

class PassiveMenu (InterfaceElement): 
	
	
	
	passive_items as List
	points_left as PassiveMenuPointsLeft
	_current_item as int
	
	lastTime as single
	
	public changeItemTime as double = 0.25
	
	current_item:
		get:
			return _current_item
		set:
			self._current_item = value%len(self.passive_items)
	
	def Awake():
		super.Awake()
		self.lastTime = Time.realtimeSinceStartup
		passives = List(self.player.passive_controller.passives.Values)
		self.passive_items = []
		for passive_kind in passives:
			for passive as Passive in passive_kind:
				self.passive_items.Add(self.gameObject.AddComponent("PassiveMenuItem"))
				(passive_items[-1] as PassiveMenuItem).passive = passive
		self.current_item = 0
		self.points_left = self.gameObject.AddComponent("PassiveMenuPointsLeft")
		
	def OnDestroy():
		for p in passive_items:
			Destroy(p)
		
	
	def DrawInterfaceElement():
		
		if Input.GetButtonDown("Attack"):
			Debug.Log("Passei aqui")
			(passive_items[self.current_item] as PassiveMenuItem).LevelUp()
		
		if Time.realtimeSinceStartup - self.lastTime >= self.changeItemTime:
			
			if Input.GetAxisRaw("Vertical") > 0.2:
				current_item = current_item - 1
				self.lastTime=Time.realtimeSinceStartup
			elif Input.GetAxisRaw("Vertical") < -0.2:
				current_item = current_item + 1
				self.lastTime=Time.realtimeSinceStartup
				Debug.Log(current_item)
			
		
		(passive_items[self.current_item-1] as PassiveMenuItem).DrawItem(-1)
		(passive_items[self.current_item] as PassiveMenuItem).DrawItem(0)
		if self.current_item == len(self.passive_items)-1:
			(passive_items[0] as PassiveMenuItem).DrawItem(1)
		else:
			(passive_items[self.current_item+1] as PassiveMenuItem).DrawItem(1)
		
		self.points_left.DrawInterfaceElement()
		