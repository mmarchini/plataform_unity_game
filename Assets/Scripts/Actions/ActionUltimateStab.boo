import UnityEngine

class ActionUltimateStab (Action): 

	char_controller as GenericChar
	already_hitted as List
	line_render as LineRenderer
	
	public material as Material
	public StartWidth as single
	public EndWidth as single 
	
	public MoveSpeedMultiplier as single = 10
	public damageMultiplier as single = 5

	def Start():
		char_controller = self.GetComponent("GenericChar")

	def Raycast(direction as Vector3, range as single):
		range = range
		ray = Ray(char_controller.GetCharPosition(), direction)
		
		if line_render:
			line_render.enabled = true
			line_render.SetPosition(0, ray.origin)
			line_render.SetPosition(1, ray.direction*range + ray.origin)  
			
		self.char_speed = self.char_controller.GetCharAttribute("MovementSpeed")*MoveSpeedMultiplier
		self.move = true
		
		raycasthit as RaycastHit
		
		if Physics.Raycast(ray, raycasthit, range):
			if raycasthit.collider != null:
				if raycasthit.collider.gameObject != null:
					if raycasthit.collider.gameObject.GetComponent("GenericChar") != null:
						char_controller as GenericChar = raycasthit.collider.gameObject.GetComponent("GenericChar")
						if char_controller != null:
							return char_controller
		return null
		
	def Update():
		_char = self.Raycast(char_controller.moveDirection, char_controller.GetCharAttribute("ATKRange"))
		if _char != null:
			if _char.tag != self.tag:
				self.DealDamage(_char)
	
	def StartAction():
		if super.StartAction():
			
			if self.material:
				if self.GetComponent(LineRenderer):
					self.line_render = self.gameObject.GetComponent(LineRenderer)
				if not self.line_render:
					self.line_render = self.gameObject.AddComponent(LineRenderer)
				self.line_render.material = self.material
				self.line_render.SetWidth(self.StartWidth, self.EndWidth)
			self.already_hitted = []
		
	def EndAction():
		super.EndAction()
		if self.line_render:
			self.line_render.enabled = false
		self.already_hitted = []
		
	def OnDestroy():
		if self.line_render:
			self.gameObject.Destroy(self.line_render)
			
	virtual def DealDamage(_char as GenericChar):
		if _char not in self.already_hitted:
			self.already_hitted.Add(_char)
			dmg as single = char_controller.DMG*self.damageMultiplier
			_char.TakeDamage(char_controller, dmg)
