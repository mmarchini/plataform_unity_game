import UnityEngine
import System.Collections
import System.Collections.Generic

class ConditionClause(System.Object):
	public name as string
	public done = false

class Condition(System.Object):
	public name as string
	public clauses as (ConditionClause)
	
class ConditionalController (MonoBehaviour): 
	public conditions as (Condition) 
	
	static def GetConditionalController():
		conditionalControllerGameObject = GameObject.Find("ConditionalController")
		if conditionalControllerGameObject:
			Debug.Log("Yeah")
			conditionalController = conditionalControllerGameObject.GetComponent(ConditionalController)
			if conditionalController:
				return conditionalController
		return null
	
	static def IsConditionSatisfied(name as string):
		satisfied = false 
		conditionalController = ConditionalController.GetConditionalController()
		if conditionalController:
			condition as Condition 
			
			for c in conditionalController.conditions:
				if c.name == name:
					condition = c
					break; 
					
			if condition: 
			 	satisfied = true
				for clause in condition.clauses:
					satisfied = satisfied and clause.done 
				
		 return satisfied
		
	static def SatisfyClause(name as string):
		conditionalController = ConditionalController.GetConditionalController()
		for condition in conditionalController.conditions:
			for clause in condition.clauses:
				if clause.name == name:
					clause.done = true 
		