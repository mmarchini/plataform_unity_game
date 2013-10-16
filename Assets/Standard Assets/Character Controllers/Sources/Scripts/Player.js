#pragma strict

class Player extends GenericChar{
	function GetHorizontalSpeed(){
		return Input.GetAxisRaw("Horizontal");
	}
	function IsJumping(){
		return (Input.GetButtonDown ("Jump") && this.IsGrounded()) || (Input.GetButtonDown ("Jump") && this.jumping);
	}
	function ExecuteAttack(){
		return Input.GetButtonDown ("Attack");
	}
}