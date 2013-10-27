import UnityEngine

class FreezeAxis (MonoBehaviour): 
	public FreezeX = false
	public FreezeY = false
	public FreezeZ = false
	private m_OriginPos as Vector3
	
	def Start ():
		m_OriginPos = transform.position
	
	def Update ():
	    currentPos = transform.position
	    if FreezeX:
	        currentPos.x = m_OriginPos.x
	    if FreezeY:
	        currentPos.y = m_OriginPos.y
	    if FreezeZ:
	        currentPos.z = m_OriginPos.z
	    transform.position = currentPos
