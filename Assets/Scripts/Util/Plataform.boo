﻿import UnityEngine

class Plataform (MonoBehaviour): 

	public plataform as GameObject
	public speed as single = 1
	
	public direction as Vector3 = Vector3(1,0,0)

	def FixedUpdate ():
		plataform.rigidbody.position += direction*speed
	
	def OnTriggerExit(collider as Collider):
		if collider.gameObject == plataform:
			direction = direction*-1
			Debug.Log(":)")

	