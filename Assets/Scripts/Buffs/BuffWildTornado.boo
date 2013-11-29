import UnityEngine

class BuffWildTornado(Buff): 

	direction as int = 1

	line_render as LineRenderer
			
	public material as Material
	public StartWidth as single= 0.8
	public EndWidth as single =0.3

	def Awake():
		self.label = "Wild Tornado"
		self.affected_attributes = []
	
	def Start():
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
		self.Reset()
		super.Start()

	def Raycast(direction as Vector3, range as single):
		ray = Ray(char_controller.GetCharPosition(), direction)
		Debug.Log(":D")		
		if line_render:
			line_render.enabled = true
			line_render.SetPosition(0, ray.origin)
			line_render.SetPosition(1, ray.direction*range + ray.origin)
		
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

	def OnDestroy():
		if self.line_render:
			self.line_render.enabled = false
	
	virtual def DealDamage(_char as GenericChar):
		dmg as single = char_controller.DMG*0.15
		_char.TakeDamage(char_controller, dmg)

	def Reset():
		super.Reset()
		self.HPSec = 5
		self.MPSec = 15