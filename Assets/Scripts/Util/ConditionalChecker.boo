import UnityEngine

enum ConditionCheckEvents:
	FixedUpdate
	LateUpdate
	Update
	Awake
	Start
	OnDestroy

class ConditionalChecker (MonoBehaviour): 

	public _event as ConditionCheckEvents
	
	public condition as string
	
	def CheckCondition():
		if ConditionalController.IsConditionSatisfied(condition):
			SendMessage("ConditionSatisfied", condition, SendMessageOptions.DontRequireReceiver)
	
	def Awake():
		if _event = ConditionCheckEvents.Awake:
			self.CheckCondition()
		
