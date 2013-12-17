import UnityEngine

class EnemyAttack(System.Object):
	public attack as string
	public distance as single
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
	public attacksByDistance as (EnemyAttack) = (EnemyAttack(distance:1.0f, attack:"BaseAttack", chance:100),)
	
	public target as GameObject
	public closestToTarget = 1.0f
	public farestToTarget = 10.0f
		
	def Start():
		if not target:
			target = GameObject.FindGameObjectWithTag("Player")
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
				player.currentEXP += self.dropEXP + self.dropEXP*(self.Level-1)*0.25
		
	def Update():
		if lastAIMovement + AIMovementDuration < Time.time:
			
			self.AIMovementDuration = GetRandomRange(1.0F, 2.0F)
			
			self.AIMovementDirection = self.target.transform.position.x - self.transform.position.x
			
			targetDistance = Vector3.Distance(self.transform.position, self.target.transform.position)
			
			if self.AIMovementDirection:
				if targetDistance >= 10.0 or targetDistance <= 1.0:
					self.AIMovementDirection = 0
				else:
					self.AIMovementDirection = self.AIMovementDirection/Mathf.Abs(self.AIMovementDirection)
			
			self.lastAIMovement = Time.time
		super.Update()
	
	horizontalSpeed:
		get:
			targetDistance = Vector3.Distance(self.transform.position, self.target.transform.position)
			if targetDistance <= closestToTarget:
				return 0
			return self.AIMovementDirection
	
	def IsJumping():
		return false
	
	def Control():
		attack as EnemyAttack = self.ExecuteAttack()
		if attack and self.action_controller:
			self.action_controller.Execute(attack.attack)
			lastAIAttack = Time.time
							
			
	
	def ExecuteAttack():
		if Time.time - lastAIAttack > AIAttackDelay:
			
			targetDistance = Vector3.Distance(self.transform.position, self.target.transform.position)
			currentAttack as EnemyAttack
			which_attack = GetRandomRange(0.0f, 100.0f)

			for a in self.attacksByDistance:
				if a.distance >= targetDistance and which_attack <= a.chance:
					if currentAttack:
						if currentAttack.distance >= a.distance:
							currentAttack = a
					else:
						currentAttack = a
					
			return currentAttack
		return null
		
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
