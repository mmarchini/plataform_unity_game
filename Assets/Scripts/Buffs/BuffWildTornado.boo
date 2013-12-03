import UnityEngine

class BuffWildTornado(Buff): 

	direction as int = 1

	public material as Material
	public StartWidth as single= 0.8
	public EndWidth as single =0.3

	def Awake():
		self.label = "Wild Tornado"
		self.affected_attributes = []
	
	def Start():
		/*
		if not self.material:
			shaderText as string ="Shader \"Alpha Additive\" {Properties { _Color (\"Main Color\", Color) = (1,1,1,0) }SubShader {	Tags { \"Queue\" = \"Transparent\" }	Pass {		Blend One One ZWrite Off ColorMask RGB		Material { Diffuse [_Color] Ambient [_Color] }		Lighting On		SetTexture [_Dummy] { combine primary double, primary }	}}}"
			self.material = Material(shaderText)
			self.material.color = Color.cyan	
		if self.GetComponent(LineRenderer):
			self.line_render = self.gameObject.GetComponent(LineRenderer)
		if not self.line_render:
			self.line_render = self.gameObject.AddComponent(LineRenderer)
		self.line_render.material = self.material
		self.line_render.SetWidth(self.StartWidth, self.EndWidth)
		*/
		self.Reset()
		super.Start()
		if self.effect:
			self.effect.transform.localPosition = Vector3(0,0.18,0)
			self.effect.transform.localScale = Vector3(0.4,0.2,0.4)

	def Raycast(direction as Vector3, range as single):
		ray = Ray(char_controller.GetCharPosition(), direction)
		
		Debug.DrawRay(ray.origin, ray.direction*range, Color.black, 0)
		
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
		_char = self.Raycast(char_controller.moveDirection*self.direction, char_controller.GetCharAttribute("ATKRange"))
		self.direction = -self.direction
		if _char != null:
			if _char.tag != self.tag:
				self.DealDamage(_char)
		super.Update()

	virtual def DealDamage(_char as GenericChar):
		dmg as single = char_controller.DMG*0.1
		_char.TakeDamage(char_controller, dmg, "JustDont")

	def Reset():
		super.Reset()
		self.HPSec = 1
		self.MPSec = 5