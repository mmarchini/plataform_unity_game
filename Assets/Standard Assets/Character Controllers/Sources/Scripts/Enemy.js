#pragma strict

class Enemy extends GenericChar{
	private var lastAIMovement = -10;
	private var AIMovementDuration = 0;
	private var AIMovementDirection = 0;
	
	function Update(){
		if(lastAIMovement + AIMovementDuration < Time.time){
			this.AIMovementDuration = Random.Range(1.0, 2.0);
			this.AIMovementDirection = Random.Range(0.0, 100.0);
			if(this.AIMovementDirection > 70.0){
				this.AIMovementDirection = 0.0;
			} else{
				if(this.AIMovementDirection < 35.0)
					this.AIMovementDirection = -1.0;
				else
					this.AIMovementDirection = 1.0;
			}
			
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
	
	function DealDamage(char_controller : GenericChar){
		this.AIMovementDuration = Random.Range(1.3, 2.8);
		this.AIMovementDirection = 0.0;
		this.lastAIMovement = Time.time;
		super.DealDamage(char_controller);
	}
	
	function OnAnotherControllerHit(hit : ControllerColliderHit){
		
	}
}