#pragma strict

@script RequireComponent(CharacterController)

var GameObjectChar : GameObject;
var GameObjectController : GameObject;

/*enum CharacterState {
	Idle = 0,
	Walking = 1,
	Trotting = 2,
	Running = 3,
	Jumping = 4,
}*/

private var _characterState : CharacterState;

//private var tr : Transform;

private var controller : CharacterController;

function Awake () {
	controller = GetComponent (CharacterController);
	//tr = transform;
}

function Start () {
}

function Update () {
	controller.Move(Vector3(1,0,0));
	
}