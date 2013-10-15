﻿#pragma strict

class GenericChar extends GenericCharController{

	// Atributos
	public var HP : int = 500;
	public var MP : int = 150;
	public var ATK : float = 14;
	public var DEF : float = 1;
	public var Spear : float = 0.05;
	public var Shield : float = 0.05;
	public var ATKRange : float = 1;
	public var CritChance : float = 0.10;
	public var CritDamage : float = 1.5;
	public var BAT : float = 1;
	public var MovementSpeed : float = 1;
	public var Jump : float = 1;
	
	function getSpear(){
	
	}
	
	function getShield(){
	
	}

	function GetWalkSpeed(){
		var horizontalSpeed : float = this.walkSpeed * this.MovementSpeed;
		if(Mathf.Abs(horizontalSpeed) > 5.5){
			return 5.5*(horizontalSpeed/Mathf.Abs(horizontalSpeed));
		}
		if(Mathf.Abs(horizontalSpeed) < 3 && horizontalSpeed != 0){
			return 3*(horizontalSpeed/Mathf.Abs(horizontalSpeed));
		}
		return horizontalSpeed;
	}
	
		

	function GetHorizontalSpeed(){
		return Input.GetAxisRaw("Horizontal");
	}
	function IsJumping(){
		return Input.GetButtonDown ("Jump");
	}
}
