//using UnityEngine;
//using System.Collections;
 
public var FreezeX = false;
public var FreezeY = false;
public var FreezeZ = false;
private var m_OriginPos : Vector3;   

function Start ()
    {
        m_OriginPos = transform.position;
    }
 
function Update ()
{
    var currentPos : Vector3 = transform.position;
    if(FreezeX)
        currentPos.x = m_OriginPos.x;
    if(FreezeY)
        currentPos.y = m_OriginPos.y;
    if(FreezeZ)
        currentPos.z = m_OriginPos.z;
    transform.position = currentPos;
}
