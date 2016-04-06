void CWeapon::Snap(int SnappingClient)
{
    if(!CanSnap(SnappingClient, m_pPlayer, true) || !m_pTotem || !m_pTotem->IsOpened())
        return;
    if(m_Index < 13 && 9 + m_pPlayer->m_AccountData.m_aTotemNumDatas[TOTEM_BOUGHT_SLOTS] < m_Index)
        return;
    if(m_Value == 0)//No snap if no value
        return;
    if(m_IsResultingWeapon && !CanBroadcast())
        return;
    if(m_NoSnapTicks >= Server()->Tick())
        return;
 
        if(m_Value >= 300 && m_Value < 1000)
    {
        CNetObj_Laser *pValue300Obj = static_cast<CNetObj_Laser *>(Server()->SnapNewItem(NETOBJTYPE_LASER, m_aExtraIDs[0], sizeof(CNetObj_Laser)));
 
        if(!pValue300Obj)
            return;
 
        pValue300Obj->m_X = (int)m_aRotateFrom[0].x;
        pValue300Obj->m_Y = (int)m_aRotateFrom[0].y;
        pValue300Obj->m_FromX = (int)m_aRotateFrom[0].x;
        pValue300Obj->m_FromY = (int)m_aRotateFrom[0].y;
        pValue300Obj->m_StartTick = Server()->Tick()-1;
    }
        else if(m_Value >= 1000)
    {
        CNetObj_Laser *apValue1000Objs[4];
        CNetObj_Pickup *apValue3000WeaponObjs[EXTRA_ID_NUM];
 
        int i = 0;
        //if(i < 4)
        {
            apValue1000Objs[i] = static_cast<CNetObj_Laser *>(Server()->SnapNewItem(NETOBJTYPE_LASER, m_aExtraIDs[i], sizeof(CNetObj_Laser)));
 
            if(!apValue1000Objs[i])
                return;
 
            apValue1000Objs[i]->m_X = (int)m_aRotateFrom[i].x;
            apValue1000Objs[i]->m_Y = (int)m_aRotateFrom[i].y;
            apValue1000Objs[i]->m_FromX = (int)m_aRotateTo[i].x;
            apValue1000Objs[i]->m_FromY = (int)m_aRotateTo[i].y;
            apValue1000Objs[i]->m_StartTick = Server()->Tick()-1;
 
            i ++;
            apValue1000Objs[i] = static_cast<CNetObj_Laser *>(Server()->SnapNewItem(NETOBJTYPE_LASER, m_aExtraIDs[i], sizeof(CNetObj_Laser)));
 
            if(!apValue1000Objs[i])
                return;
 
            apValue1000Objs[i]->m_X = (int)m_aRotateFrom[i].x;
            apValue1000Objs[i]->m_Y = (int)m_aRotateFrom[i].y;
            apValue1000Objs[i]->m_FromX = (int)m_aRotateTo[i].x;
            apValue1000Objs[i]->m_FromY = (int)m_aRotateTo[i].y;
            apValue1000Objs[i]->m_StartTick = Server()->Tick()-1;
 
            i ++;
            apValue1000Objs[i] = static_cast<CNetObj_Laser *>(Server()->SnapNewItem(NETOBJTYPE_LASER, m_aExtraIDs[i], sizeof(CNetObj_Laser)));
 
            if(!apValue1000Objs[i])
                return;
 
            apValue1000Objs[i]->m_X = (int)m_aRotateFrom[i].x;
            apValue1000Objs[i]->m_Y = (int)m_aRotateFrom[i].y;
            apValue1000Objs[i]->m_FromX = (int)m_aRotateTo[i].x;
            apValue1000Objs[i]->m_FromY = (int)m_aRotateTo[i].y;
            apValue1000Objs[i]->m_StartTick = Server()->Tick()-1;
 
            i ++;
            apValue1000Objs[i] = static_cast<CNetObj_Laser *>(Server()->SnapNewItem(NETOBJTYPE_LASER, m_aExtraIDs[i], sizeof(CNetObj_Laser)));
 
            if(!apValue1000Objs[i])
                return;
 
            apValue1000Objs[i]->m_X = (int)m_aRotateFrom[i].x;
            apValue1000Objs[i]->m_Y = (int)m_aRotateFrom[i].y;
            apValue1000Objs[i]->m_FromX = (int)m_aRotateTo[i].x;
            apValue1000Objs[i]->m_FromY = (int)m_aRotateTo[i].y;
            apValue1000Objs[i]->m_StartTick = Server()->Tick()-1;
 
            i = 4;
        }
        if(m_Value < 3000)
            goto out;
        else if(m_Value < 100000)
        {
            apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
            if(!apValue3000WeaponObjs[i])
                return;
 
            apValue3000WeaponObjs[i]->m_X = (int)m_aRotateFrom[i-4].x;
            apValue3000WeaponObjs[i]->m_Y = (int)m_aRotateFrom[i-4].y;
            apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
            apValue3000WeaponObjs[i]->m_Subtype = m_Type;
            i++;
            if(m_Value < 10000)
                goto out;
            apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
            if(!apValue3000WeaponObjs[i])
                return;
 
            apValue3000WeaponObjs[i]->m_X = (int)m_aRotateFrom[i-4].x;
            apValue3000WeaponObjs[i]->m_Y = (int)m_aRotateFrom[i-4].y;
            apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
            apValue3000WeaponObjs[i]->m_Subtype = m_Type;
            i++;
            if(m_Value < 30000)
                goto out;
            apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
            if(!apValue3000WeaponObjs[i])
                return;
            apValue3000WeaponObjs[i]->m_X = (int)m_aRotateFrom[i-4].x;
            apValue3000WeaponObjs[i]->m_Y = (int)m_aRotateFrom[i-4].y;
            apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
            apValue3000WeaponObjs[i]->m_Subtype = m_Type;
            goto out;
        }
        else// if(m_Value < 3000000)
        {
            apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
            if(!apValue3000WeaponObjs[i])
                return;
 
            apValue3000WeaponObjs[i]->m_X = (int)m_aRotateFrom[i-4].x;
            apValue3000WeaponObjs[i]->m_Y = (int)m_aRotateFrom[i-4].y;
            apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
            apValue3000WeaponObjs[i]->m_Subtype = m_Type;
            i++;
            apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
            if(!apValue3000WeaponObjs[i])
                return;
 
            apValue3000WeaponObjs[i]->m_X = (int)m_aRotateFrom[i-4].x;
            apValue3000WeaponObjs[i]->m_Y = (int)m_aRotateFrom[i-4].y;
            apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
            apValue3000WeaponObjs[i]->m_Subtype = m_Type;
            i++;
            apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
            if(!apValue3000WeaponObjs[i])
                return;
 
            apValue3000WeaponObjs[i]->m_X = (int)m_aRotateFrom[i-4].x;
            apValue3000WeaponObjs[i]->m_Y = (int)m_aRotateFrom[i-4].y;
            apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
            apValue3000WeaponObjs[i]->m_Subtype = m_Type;
            i++;
 
            apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
            if(!apValue3000WeaponObjs[i])
                return;
 
            apValue3000WeaponObjs[i]->m_X = (int)(m_SnapPos.x + m_aWeaponPos[i-7].x);
            apValue3000WeaponObjs[i]->m_Y = (int)(m_SnapPos.y + m_aWeaponPos[i-7].y);
            apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
            apValue3000WeaponObjs[i]->m_Subtype = m_Type;
            i++;
 
            apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
            if(!apValue3000WeaponObjs[i])
                return;
 
            apValue3000WeaponObjs[i]->m_X = (int)(m_SnapPos.x + m_aWeaponPos[i-7].x);
            apValue3000WeaponObjs[i]->m_Y = (int)(m_SnapPos.y + m_aWeaponPos[i-7].y);
            apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
            apValue3000WeaponObjs[i]->m_Subtype = m_Type;
            i++;
 
            if(m_Value < 300000)
                goto out;
 
            apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
            if(!apValue3000WeaponObjs[i])
                return;
 
            apValue3000WeaponObjs[i]->m_X = (int)(m_SnapPos.x + m_aWeaponPos[i-7].x);
            apValue3000WeaponObjs[i]->m_Y = (int)(m_SnapPos.y + m_aWeaponPos[i-7].y);
            apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
            apValue3000WeaponObjs[i]->m_Subtype = m_Type;
            i++;
 
            apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
            if(!apValue3000WeaponObjs[i])
                return;
 
            apValue3000WeaponObjs[i]->m_X = (int)(m_SnapPos.x + m_aWeaponPos[i-7].x);
            apValue3000WeaponObjs[i]->m_Y = (int)(m_SnapPos.y + m_aWeaponPos[i-7].y);
            apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
            apValue3000WeaponObjs[i]->m_Subtype = m_Type;
            i++;
 
            if(m_Value < 1000000)
                goto out;
 
            apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
            if(!apValue3000WeaponObjs[i])
                return;
 
            apValue3000WeaponObjs[i]->m_X = (int)(m_SnapPos.x + m_aWeaponPos[i-7].x);
            apValue3000WeaponObjs[i]->m_Y = (int)(m_SnapPos.y + m_aWeaponPos[i-7].y);
            apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
            apValue3000WeaponObjs[i]->m_Subtype = m_Type;
            i++;
 
            apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
            if(!apValue3000WeaponObjs[i])
                return;
 
            apValue3000WeaponObjs[i]->m_X = (int)(m_SnapPos.x + m_aWeaponPos[i-7].x);
            apValue3000WeaponObjs[i]->m_Y = (int)(m_SnapPos.y + m_aWeaponPos[i-7].y);
            apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
            apValue3000WeaponObjs[i]->m_Subtype = m_Type;
        }
    }
    out:
 
    CNetObj_Pickup *pWeaponObj = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_ID, sizeof(CNetObj_Pickup)));
        if(!pWeaponObj)
                return;
 
        pWeaponObj->m_X = (int)m_SnapPos.x;
        pWeaponObj->m_Y = (int)m_SnapPos.y;
        pWeaponObj->m_Type = POWERUP_WEAPON;
        pWeaponObj->m_Subtype = m_Type;
}
 
///////////////// THREAD /////////////////
void CWeapon::Snap(int SnappingClient)
{
    m_aDoSnap[SnappingClient] = true;
}
 
void CWeapon::SnapThread(void *pUser)
{
        CWeapon *pSelf = (CWeapon *)pUser;
 
    while(true)
    {
        thread_sleep(1);
        for(int SnappingID = 0; SnappingID < MAX_CLIENTS; SnappingID ++)
        {
            if(pSelf->m_MarkedForDestroy)
                return;
            if(!pSelf->m_aDoSnap[SnappingID])
                continue;
 
            if(!pSelf->CanSnap(SnappingID, pSelf->m_pPlayer, true) || !pSelf->m_pTotem || !pSelf->m_pTotem->IsOpened())
                continue;
            if(pSelf->m_Index < 13 && 9 + pSelf->m_pPlayer->m_AccountData.m_aTotemNumDatas[TOTEM_BOUGHT_SLOTS] < pSelf->m_Index)
                continue;
            if(pSelf->m_Value == 0)//No snap if no value
                continue;
            if(pSelf->m_IsResultingWeapon && !pSelf->CanBroadcast())
                continue;
            if(pSelf->m_NoSnapTicks >= pSelf->Server()->Tick())
                continue;
 
            if(pSelf->m_Value >= 300 && pSelf->m_Value < 1000)
            {
                CNetObj_Laser *pValue300Obj = static_cast<CNetObj_Laser *>(pSelf->Server()->SnapNewItem(NETOBJTYPE_LASER, pSelf->m_aExtraIDs[0], sizeof(CNetObj_Laser)));
 
                if(!pValue300Obj)
                    continue;
 
                pValue300Obj->m_X = (int)pSelf->m_aRotateFrom[0].x;
                pValue300Obj->m_Y = (int)pSelf->m_aRotateFrom[0].y;
                pValue300Obj->m_FromX = (int)pSelf->m_aRotateFrom[0].x;
                pValue300Obj->m_FromY = (int)pSelf->m_aRotateFrom[0].y;
                pValue300Obj->m_StartTick = pSelf->Server()->Tick()-1;
            }
            else if(pSelf->m_Value >= 1000)
            {
                CNetObj_Laser *apValue1000Objs[4];
                CNetObj_Pickup *apValue3000WeaponObjs[EXTRA_ID_NUM];
 
                for(int i = 0; i < EXTRA_ID_NUM; i++)
                {
                    if(i < 4)
                    {
                        apValue1000Objs[i] = static_cast<CNetObj_Laser *>(pSelf->Server()->SnapNewItem(NETOBJTYPE_LASER, pSelf->m_aExtraIDs[i], sizeof(CNetObj_Laser)));
 
                        if(!apValue1000Objs[i])
                            break;
 
                        apValue1000Objs[i]->m_X = (int)pSelf->m_aRotateFrom[i].x;
                        apValue1000Objs[i]->m_Y = (int)pSelf->m_aRotateFrom[i].y;
                        apValue1000Objs[i]->m_FromX = (int)pSelf->m_aRotateTo[i].x;
                        apValue1000Objs[i]->m_FromY = (int)pSelf->m_aRotateTo[i].y;
                        apValue1000Objs[i]->m_StartTick = pSelf->Server()->Tick()-1;
                    }
                    else if(pSelf->m_Value < 3000)
                        break;
                    else if(pSelf->m_Value < 100000)
                    {
                        if(i == 5 && pSelf->m_Value < 10000)
                            break;
                        if(i == 6 && pSelf->m_Value < 30000)
                            break;
                        if(i == 7)
                            break;
                        apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(pSelf->Server()->SnapNewItem(NETOBJTYPE_PICKUP, pSelf->m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
                        if(!apValue3000WeaponObjs[i])
                            break;
 
                        apValue3000WeaponObjs[i]->m_X = (int)pSelf->m_aRotateFrom[i-4].x;
                        apValue3000WeaponObjs[i]->m_Y = (int)pSelf->m_aRotateFrom[i-4].y;
                        apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
                        apValue3000WeaponObjs[i]->m_Subtype = pSelf->m_Type;
                    }
                    else// if(m_Value < 3000000)
                    {
                        if(i < 7)
                        {
                            apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(pSelf->Server()->SnapNewItem(NETOBJTYPE_PICKUP, pSelf->m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
                            if(!apValue3000WeaponObjs[i])
                                break;
 
                            apValue3000WeaponObjs[i]->m_X = (int)pSelf->m_aRotateFrom[i-4].x;
                            apValue3000WeaponObjs[i]->m_Y = (int)pSelf->m_aRotateFrom[i-4].y;
                            apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
                            apValue3000WeaponObjs[i]->m_Subtype = pSelf->m_Type;
 
                            continue;
                        }
 
                        if(i == 9 && pSelf->m_Value < 300000)
                            break;
 
                        if(i == 11 && pSelf->m_Value < 1000000)
                            break;
 
                        apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(pSelf->Server()->SnapNewItem(NETOBJTYPE_PICKUP, pSelf->m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
                        if(!apValue3000WeaponObjs[i])
                            break;
 
                        apValue3000WeaponObjs[i]->m_X = (int)(pSelf->m_SnapPos.x + pSelf->m_aWeaponPos[i-7].x);
                        apValue3000WeaponObjs[i]->m_Y = (int)(pSelf->m_SnapPos.y + pSelf->m_aWeaponPos[i-7].y);
                        apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
                        apValue3000WeaponObjs[i]->m_Subtype = pSelf->m_Type;
                    }
                }
            }
 
            CNetObj_Pickup *pWeaponObj = static_cast<CNetObj_Pickup *>(pSelf->Server()->SnapNewItem(NETOBJTYPE_PICKUP, pSelf->m_ID, sizeof(CNetObj_Pickup)));
            if(!pWeaponObj)
                continue;
 
            pWeaponObj->m_X = (int)pSelf->m_SnapPos.x;
            pWeaponObj->m_Y = (int)pSelf->m_SnapPos.y;
            pWeaponObj->m_Type = POWERUP_WEAPON;
            pWeaponObj->m_Subtype = pSelf->m_Type;
 
            pSelf->m_aDoSnap[SnappingID] = false;
        }
    }
}
///////////////// THREAD /////////////////
 
///////////////// NORMAL SNAP /////////////////
void CWeapon::Snap(int SnappingClient)
{
    if(!CanSnap(SnappingClient, m_pPlayer, true) || !m_pTotem || !m_pTotem->IsOpened())
        return;
    if(m_Index < 13 && 9 + m_pPlayer->m_AccountData.m_aTotemNumDatas[TOTEM_BOUGHT_SLOTS] < m_Index)
        return;
    if(m_Value == 0)//No snap if no value
        return;
    if(m_IsResultingWeapon && !CanBroadcast())
        return;
    if(m_NoSnapTicks >= Server()->Tick())
        return;
 
        if(m_Value >= 300 && m_Value < 1000)
    {
        CNetObj_Laser *pValue300Obj = static_cast<CNetObj_Laser *>(Server()->SnapNewItem(NETOBJTYPE_LASER, m_aExtraIDs[0], sizeof(CNetObj_Laser)));
 
        if(!pValue300Obj)
            return;
 
        pValue300Obj->m_X = (int)m_aRotateFrom[0].x;
        pValue300Obj->m_Y = (int)m_aRotateFrom[0].y;
        pValue300Obj->m_FromX = (int)m_aRotateFrom[0].x;
        pValue300Obj->m_FromY = (int)m_aRotateFrom[0].y;
        pValue300Obj->m_StartTick = Server()->Tick()-1;
    }
        else if(m_Value >= 1000)
    {
        CNetObj_Laser *apValue1000Objs[4];
        CNetObj_Pickup *apValue3000WeaponObjs[EXTRA_ID_NUM];
 
        for(int i = 0; i < EXTRA_ID_NUM; i++)
        {
            if(i < 4)
            {
                apValue1000Objs[i] = static_cast<CNetObj_Laser *>(Server()->SnapNewItem(NETOBJTYPE_LASER, m_aExtraIDs[i], sizeof(CNetObj_Laser)));
 
                if(!apValue1000Objs[i])
                    return;
 
                apValue1000Objs[i]->m_X = (int)m_aRotateFrom[i].x;
                apValue1000Objs[i]->m_Y = (int)m_aRotateFrom[i].y;
                apValue1000Objs[i]->m_FromX = (int)m_aRotateTo[i].x;
                apValue1000Objs[i]->m_FromY = (int)m_aRotateTo[i].y;
                apValue1000Objs[i]->m_StartTick = Server()->Tick()-1;
            }
            else if(m_Value < 3000)
                break;
            else if(m_Value < 100000)
            {
                if(i == 5 && m_Value < 10000)
                    break;
                if(i == 6 && m_Value < 30000)
                    break;
                if(i == 7)
                    break;
                apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
                if(!apValue3000WeaponObjs[i])
                    return;
 
                apValue3000WeaponObjs[i]->m_X = (int)m_aRotateFrom[i-4].x;
                apValue3000WeaponObjs[i]->m_Y = (int)m_aRotateFrom[i-4].y;
                apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
                apValue3000WeaponObjs[i]->m_Subtype = m_Type;
            }
            else// if(m_Value < 3000000)
            {
                if(i < 7)
                {
                    apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
                    if(!apValue3000WeaponObjs[i])
                        return;
 
                    apValue3000WeaponObjs[i]->m_X = (int)m_aRotateFrom[i-4].x;
                    apValue3000WeaponObjs[i]->m_Y = (int)m_aRotateFrom[i-4].y;
                    apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
                    apValue3000WeaponObjs[i]->m_Subtype = m_Type;
 
                    continue;
                }
 
                if(i == 9 && m_Value < 300000)
                    break;
 
                if(i == 11 && m_Value < 1000000)
                    break;
 
                apValue3000WeaponObjs[i] = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_aExtraIDs[i], sizeof(CNetObj_Pickup)));
                if(!apValue3000WeaponObjs[i])
                    return;
 
                apValue3000WeaponObjs[i]->m_X = (int)(m_SnapPos.x + m_aWeaponPos[i-7].x);
                apValue3000WeaponObjs[i]->m_Y = (int)(m_SnapPos.y + m_aWeaponPos[i-7].y);
                apValue3000WeaponObjs[i]->m_Type = POWERUP_WEAPON;
                apValue3000WeaponObjs[i]->m_Subtype = m_Type;
            }
        }
    }
 
    CNetObj_Pickup *pWeaponObj = static_cast<CNetObj_Pickup *>(Server()->SnapNewItem(NETOBJTYPE_PICKUP, m_ID, sizeof(CNetObj_Pickup)));
        if(!pWeaponObj)
                return;
 
        pWeaponObj->m_X = (int)m_SnapPos.x;
        pWeaponObj->m_Y = (int)m_SnapPos.y;
        pWeaponObj->m_Type = POWERUP_WEAPON;
        pWeaponObj->m_Subtype = m_Type;
}
///////////////// NORMAL SNAP /////////////////