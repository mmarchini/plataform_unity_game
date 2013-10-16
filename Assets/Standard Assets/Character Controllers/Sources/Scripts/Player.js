#pragma strict

class Player extends GenericChar{
	function GetHorizontalSpeed(){
		if(damaged)
			return 0;
		return Input.GetAxisRaw("Horizontal");
	}
	
	function IsJumping(){
		return (Input.GetButtonDown ("Jump") && this.IsGrounded()) || (Input.GetButtonDown ("Jump") && this.jumping) && !damaged;
	}
	
	function ExecuteAttack(){
		return Input.GetButtonDown ("Attack") && !damaged;
	}
	
	function OnAnotherControllerHit(hit : ControllerColliderHit){
		var char_controller : GenericChar = hit.gameObject.GetComponent("GenericChar");
		if(char_controller && char_controller.Type && char_controller.Type != ControllerType.Player){
			if(this.attacking)
				this.DealDamage(char_controller);
		}
	}
	
}