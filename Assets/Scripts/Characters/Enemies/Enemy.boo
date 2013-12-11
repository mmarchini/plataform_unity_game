import UnityEngine

class EnemyAttack(System.Object):
	public attack as string
	public chance as single

class Enemy (GenericChar): 
	private lastAIMovement = -10
	private lastAIAttack = -10
	private AIMovementDuration = 0
	public AIAttackDelay = 6
	private AIMovementDirection = 0
	public dropEXP as single = 15.0f
	public damageClip as AudioClip
	
	public chanceOfAttack as int = 15
	public attacksByChance as (EnemyAttack) = (EnemyAttack(attack:"BaseAttack", chance:100),)
		
	def Start():
		a = Resources.Load("Prefabs/EnemyHP", GameObject) as GameObject
		if a:
			go as GameObject = Instantiate(a)
			go.transform.parent = self.gameObject.transform
			go.transform.localPosition = Vector3(0,self.height,0)
			(go.GetComponent("EnemyHP") as EnemyHP).forward = Vector3(0,0,1)
		
	def OnDestroy():
		playergo = GameObject.FindGameObjectWithTag("Player")
		if playergo:
			player as Player = playergo.GetComponent("Player")
			if self.CurrentHP <= 0 and player:
				player.currentEXP += self.dropEXP
		
	def Update():
		if lastAIMovement + AIMovementDuration < Time.time:
			
			self.AIMovementDuration = GetRandomRange(1.0F, 2.0F)
			self.AIMovementDirection = GetRandomRange(0.0F, 100.0F)
			if self.AIMovementDirection > 70.0:
				self.AIMovementDirection = 0.0
			elif self.AIMovementDirection < 35.0:
				self.AIMovementDirection = -1.0
			else:
				self.AIMovementDirection = 1.0
			self.lastAIMovement = Time.time
		super.Update()
	
	horizontalSpeed:
		get:
			return self.AIMovementDirection
	
	def IsJumping():
		return false
	
	def Control():
		if self.ExecuteAttack():
			if self.action_controller:
				if self.attacksByChance:
					which_attack = GetRandomRange(0.0f, 100.0f)
					last_chance = 0
					for attack in self.attacksByChance:
						Debug.Log(which_attack)
						Debug.Log(last_chance)
						if which_attack <= attack.chance+last_chance:
							self.action_controller.Execute(attack.attack)
							break;
						else:
							last_chance += attack.chance
							
							
			
	
	def ExecuteAttack():
		if Time.time - lastAIAttack > AIAttackDelay:
			if GetRandomRange(0, 100) <= self.chanceOfAttack:
				lastAIAttack = Time.time
				return true
		return false
		
	def GetRandomRange(start as int, end as int):
		/*
		tmp_seed = Random.Range(Random.Range(-100.0F, -0.1F), Random.Range(0.1F, 100.0F))
		a=System.DateTime.Now.Millisecond*Random.Range(Random.Range(-10.0F, -0.1F), Random.Range(0.1F, 10.0F))
		for i in range(0,tmp_seed):
			if Random.Range(0.0F, 1000.0F) >= 700.0:
				a = System.DateTime.Now.Millisecond*Random.Range(Random.Range(-10.0F, -0.1F), Random.Range(0.1F, 10.0F))
		
		b=System.DateTime.Now.Millisecond*self.GetInstanceID()
		c=System.DateTime.Now.Second*self.CurrentHP
		d=System.DateTime.Now.Millisecond*System.DateTime.Now.Second
		e=self.transform.position.x + self.transform.position.y + self.transform.position.z
		f_=Random.insideUnitSphere
		f=f_.x+f_.y+f_.z
		*/
		#Random.seed = a + (c*e + d*a)/b + b*f
		return Random.Range(start, end)	
	
	def GetRandomRange(start as single, end as single):
		/*
		tmp_seed = Random.Range(Random.Range(-100.0F, -0.1F), Random.Range(0.1F, 100.0F))
		a=System.DateTime.Now.Millisecond*Random.Range(Random.Range(-10.0F, -0.1F), Random.Range(0.1F, 10.0F))
		for i in range(0,tmp_seed):
			if Random.Range(0.0F, 1000.0F) >= 700.0:
				a = System.DateTime.Now.Millisecond*Random.Range(Random.Range(-10.0F, -0.1F), Random.Range(0.1F, 10.0F))
		
		b=System.DateTime.Now.Millisecond*self.GetInstanceID()
		c=System.DateTime.Now.Second*self.CurrentHP
		d=System.DateTime.Now.Millisecond*System.DateTime.Now.Second
		e=self.transform.position.x + self.transform.position.y + self.transform.position.z
		f_=Random.insideUnitSphere
		f=f_.x+f_.y+f_.z
		*/		
		#Random.seed = a + (c*e + d*a)/b + b*f
		return Random.Range(start, end)
