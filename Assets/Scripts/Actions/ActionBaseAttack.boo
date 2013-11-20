import UnityEngine

class ActionBaseAttack (Action): 

	char_controller as GenericChar
	already_hitted as List

	def Start():
		char_controller = self.GetComponent("GenericChar")

	def Raycast(direction as Vector3, range as single):
		ray = Ray(char_controller.GetCharPosition(), direction)
		
		Debug.DrawRay(ray.origin, ray.direction*range, Color.black, 0)
		
		line_render as LineRenderer = self.GetComponent("LineRenderer")
		if line_render:
			line_render.SetPosition(0, ray.origin)
			line_render.SetPosition(1, ray.direction*range + ray.origin)
			#line_render.material = line_render.materials[self.GetAttackMaterial()]
		
		
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
		super.StartAction()
		self.already_hitted = []
						
	virtual def DealDamage(_char as GenericChar):
		if _char not in self.already_hitted:
			self.already_hitted.Add(_char)
			dmg as single = char_controller.DMG
			_char.TakeDamage(char_controller, dmg)
	
