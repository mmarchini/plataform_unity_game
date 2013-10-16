#pragma strict

class Enemy extends GenericChar{
	private var lastAIMovement = -10;
	private var AIMovementDuration = 0;
	private var AIMovementDirection = 0;
	
	function Update(){
		if(lastAIMovement + AIMovementDuration < Time.time){
			this.AIMovementDuration = Random.Range(1.0, 2.0);
			this.AIMovementDirection = Random.Range(-1.0, 1.0)*this.GetWalkSpeed() * 0.9;
			this.lastAIMovement = Time.time;
		}
		super.Update();
	}

	function GetHorizontalSpeed(){
		return AIMovementDirection;
	}
	function IsJumping(){
		return false;
	}
	function ExecuteAttack(){
		return false;
	}
	
	function OnAnotherControllerHit(hit : ControllerColliderHit){
	}
}