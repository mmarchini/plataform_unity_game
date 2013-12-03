import UnityEngine
import CurrentSkill

class Player (GenericChar): 

	public attackClip as AudioClip

	public SelOrbs as List = ["Wind", "Fire", "Water"]

	private _paused = false
	
	private lastLevel as string
	private trueHero = false

	paused:
		get:
			return _paused
		set:
			_paused = value

	def Awake():
		if GameObject.FindGameObjectWithTag("Player") and GameObject.FindGameObjectWithTag("Player").GetInstanceID() != self.gameObject.GetInstanceID():
			if not self.trueHero:
				Destroy(self.transform.parent.gameObject)
		self.trueHero = true
		self.passive_controller = self.GetComponent("PassiveController")
		self.skill_controller = self.GetComponent("SkillController")
		self.buff_controller = self.GetComponent("BuffController")
		self.passive_controller.generic_char = self
		self.lastLevel = Application.loadedLevelName
		Debug.Log(self.lastLevel)
		
		super.Awake()

	horizontalSpeed:
		get:
			return Input.GetAxisRaw("Horizontal")*self.GetCharAttribute("MovementSpeed")
	
	def Control(): 
		if not self.GetComponent("Buff"):
			if Input.GetButtonDown("Fire"):
				self.SelOrbs = ["Fire"] + self.SelOrbs[:-1]
			if Input.GetButtonDown("Water"):
				self.SelOrbs = ["Water"] + self.SelOrbs[:-1]
			if Input.GetButtonDown("Wind"):
				self.SelOrbs = ["Wind"] + self.SelOrbs[:-1]
		if Input.GetButtonDown("Skill"):
			if self.skill_controller:
				self.skill_controller.Execute(self, GetCurrentSkill(self))
		if Input.GetButtonDown("Attack"):
			if self.action_controller:
				self.action_controller.Execute("BaseAttack")
		
	
	def Update():
		super.Update()
	
	skills:
		get:
			return {
		["Fire" , "Fire" , "Fire" ] : Skill(label:"Fire Ball",       call:"FireBall"      , type:"Action", neededMP:30.0, spentMP:30.0),
		["Fire" , "Fire" , "Wind" ] : Skill(label:"Fire Slash",      call:"FireSlash"     , type:"Action", neededMP:10.0, spentMP:10.0),
		["Fire" , "Fire" , "Water"] : Skill(label:"Lava Sword",      call:"LavaSword"     , type:"PermaBuff"  , neededMP:0.0 , spentMP:0.0 ),
		["Water", "Water", "Water"] : Skill(label:"Water Suit",      call:"WaterSuit"     , type:"PermaBuff"  , neededMP:0.0 , spentMP:0.0 ),
		["Water", "Water", "Wind" ] : Skill(label:"Liquid Cut",      call:"LiquidCut"     , type:"Action", neededMP:20.0, spentMP:20.0),
		["Water", "Water", "Fire" ] : Skill(label:"Hot Steam",       call:"HotSteam"      , type:"PermaBuff"  , neededMP:15.0, spentMP:15.0 ),
		["Wind" , "Wind" , "Wind" ] : Skill(label:"Wind Strike",     call:"WindStrike"    , type:"Action", neededMP:20.0, spentMP:20.0 ),
		["Wind" , "Wind" , "Fire" ] : Skill(label:"Wild Tornado",    call:"WildTornado"   , type:"PermaBuff"  , neededMP:0.0, spentMP:0.0 ),
		["Wind" , "Wind" , "Water"] : Skill(label:"Aerial Movement", call:"AerialMovement", type:"PermaBuff"  , neededMP:0.0, spentMP:0.0 ),
		
		["Fire" , "Water", "Wind" ] : Skill(label:"Ultimate Stab",   call:"UltimateStab"  , type:"Action", 
		neededMP:self.GetCharAttribute("MP")*0.3, spentMP:self.GetCharAttribute("MP")*0.3, neededHP:self.GetCharAttribute("HP")*0.3, spentHP:self.GetCharAttribute("HP")*0.1 ),
	}
	
	JumpAction:
		get:
			return Input.GetButtonDown ("Jump")
		
	def OnControllerColliderHit(hit as ControllerColliderHit):
		if hit.transform.tag == "ChangeScene":
    		hit.transform.SendMessage("OnPlayerHit", SendMessageOptions.DontRequireReceiver)

	def OnLevelWasLoaded(level):
		player_position = GameObject.Find("PlayerPosition$(self.lastLevel)")
		Debug.Log("PlayerPosition$(self.lastLevel)")
		if player_position:
			self.transform.position = player_position.transform.position
			Destroy(player_position)
		
		self.lastLevel = Application.loadedLevelName
