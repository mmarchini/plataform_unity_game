import UnityEngine

class Player (GenericChar): 

	public SelOrbs as List = ["Wind", "Fire", "Water"]
	private _paused = false

	paused:
		get:
			return _paused
		set:
			_paused = value

	def Awake():
		self.passive_controller = self.GetComponent("PassiveController")
		super.Awake()

	def GetHorizontalSpeed():
		if damaged:
			return 0
		return Input.GetAxisRaw("Horizontal")
	
	def Update():
		if Input.GetButtonDown("Fire"):
			self.SelOrbs = ["Fire"] + self.SelOrbs[:-1]
		if Input.GetButtonDown("Water"):
			self.SelOrbs = ["Water"] + self.SelOrbs[:-1]
		if Input.GetButtonDown("Wind"):
			self.SelOrbs = ["Wind"] + self.SelOrbs[:-1]
		Debug.Log(self.SelOrbs)
			
		super.Update()
	
	JumpAction:
		get:
			return Input.GetButtonDown ("Jump")
		
	def ExecuteAttack():
		return Input.GetButtonDown ("Attack") and not damaged

	def OnAnotherControllerHit(hit as ControllerColliderHit):
		char_controller as GenericChar = hit.gameObject.GetComponent("GenericChar")
		if char_controller and char_controller.Type and char_controller.Type == ControllerType.Enemy:
			if (self.attacking and (not char_controller.attacking)) and not self.damaged and not char_controller.damaged:
				DealDamage(char_controller)
			elif not self.damaged:
				char_controller.DealDamage(self)
	
		//Debug.Log("Player")
		//var char_controller : GenericChar = hit.gameObject.GetComponent("GenericChar")
		//if(char_controller and char_controller.Type and char_controller.Type != ControllerType.Player){
		//	if(self.attacking)
		//		self.DealDamage(char_controller)
		//}
