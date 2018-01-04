#include "Customize_Npc.h"

#pragma warning(disable : 4018)

struct CustomizeActions {
  uint32 Action;    // Faction Change / Rename / etc
  int32 Amount;     // Costs in gold / -ItemId for purchase
  uint32 NpcTextId; // From db

  // Used to convert int/item to string
  std::string GetAmountString(Player *pPlayer) {
    if (Amount == 0)
      return "Umsonst!";
    else if (Amount < 0) {
      uint32 entry = std::abs(Amount);
      if (const ItemTemplate *temp = sObjectMgr->GetItemTemplate(entry)) {
        int loc_idx = pPlayer->GetSession()->GetSessionDbLocaleIndex();
        std::string name = temp->Name1;
        if (ItemLocale const *il = sObjectMgr->GetItemLocale(entry))
          ObjectMgr::GetLocaleString(il->Name, loc_idx, name);

        std::ostringstream oss;
        oss << "|c" << std::hex << ItemQualityColors[temp->Quality] << std::dec
            << "|Hitem:" << entry << ":0:0:0:0:0:0:0:0:0|h[" << name << "]|h|r";
        return oss.str();
      }
    } else {
      std::ostringstream oss;
      oss << this->Amount << " Gold";
      return oss.str();
    }

    return "error";
  }
};

CustomizeActions customizeActions[]{
    // Action - Amount - NpcTextId
    {GOSSIP_ACTION_CHANGE_FACTION, GOLD_PURCHASE_FACTION_CHANGE, 60005},
    {GOSSIP_ACTION_CHANGE_FACTION, ITEM_PURCHASE_FACTION_CHANGE, 60005},
    {GOSSIP_ACTION_CHANGE_RACE, GOLD_PURCHASE_CHANGE_RACE, 60006},
    {GOSSIP_ACTION_CHANGE_CHAR, GOLD_PURCHASE_CHANGE_CHAR, 60007},
    {GOSSIP_ACTION_CHANGE_NAME, GOLD_PURCHASE_CHANGE_NAME, 60008}};

bool Npc_Customize::OnGossipHello(Player *pPlayer, Creature *pCreature) {
  uint32 menuId = Player::GetDefaultGossipMenuForSource(pCreature);
  uint32 textId = pPlayer->GetGossipTextId(pCreature);

  if (sWorld->getIntConfig(CONFIG_FACTION_TRANSFER_FACTIONS_ENABLED) &
      (pPlayer->GetTeamId() + 1))
    pPlayer->ADD_GOSSIP_ITEM_DB(menuId, GOSSIP_ACTION_CHANGE_FACTION,
                                GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

  pPlayer->ADD_GOSSIP_ITEM_DB(menuId, GOSSIP_ACTION_CHANGE_RACE,
                              GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
  pPlayer->ADD_GOSSIP_ITEM_DB(menuId, GOSSIP_ACTION_CHANGE_CHAR,
                              GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
  pPlayer->ADD_GOSSIP_ITEM_DB(menuId, GOSSIP_ACTION_CHANGE_NAME,
                              GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

  pPlayer->SEND_GOSSIP_MENU(60013, pCreature->GetGUID());
  return true;
}

bool Npc_Customize::OnGossipSelect(Player *pPlayer, Creature *pCreature,
                                   uint32 /*sender*/, uint32 action) {
  pPlayer->PlayerTalkClass->ClearMenus();

  if (action == GOSSIP_ACTION_INFO_DEF - 1) {
    pPlayer->CLOSE_GOSSIP_MENU();
    return true;
  }

  action -= GOSSIP_ACTION_INFO_DEF;

  uint32 menuId = Player::GetDefaultGossipMenuForSource(pCreature);
  uint32 textId = 0;
  uint8 optionId = 0;

  if (action < GOSSIP_ACTION_MAX) {
    pPlayer->ADD_GOSSIP_ITEM_DB(60000, GOSSIP_ACTION_MAX, GOSSIP_SENDER_MAIN,
                                GOSSIP_ACTION_INFO_DEF - 1);

    for (uint8 i = 0; i < sizeof(customizeActions) / sizeof(CustomizeActions);
         ++i) {
      if (customizeActions[i].Action == action) {
        std::string amountString = customizeActions[i].GetAmountString(pPlayer);
        if (amountString == "error") {
          textId = NPC_TEXT_ERROR;
          break;
        }

        if (action)
          ++optionId;

        pPlayer->ADD_GOSSIP_ITEM(
            GOSSIP_ICON_MONEY_BAG,
            customizeActions[i].GetAmountString(pPlayer).c_str(),
            GOSSIP_SENDER_MAIN, (GOSSIP_ACTION_INFO_DEF +
                                 GOSSIP_ACTION_INFO_DEF + action + optionId));
        ++optionId;
      }
    }
  } else if (action >= GOSSIP_ACTION_INFO_DEF)
      textId = proceedAction(pPlayer, action);
  else
    textId = NPC_TEXT_ERROR;

  pPlayer->SEND_GOSSIP_MENU(textId ? textId
                                   : customizeActions[action].NpcTextId,
                            pCreature->GetGUID());
  return true;
}

bool Npc_Customize::checkAndTakeCurrency(Player *pPlayer, uint32 actionId) {

  if (customizeActions[actionId].Amount >= 0) { // Gold
    if (pPlayer->GetMoney() < (customizeActions[actionId].Amount * GOLD))
      return false;

    pPlayer->SetMoney(pPlayer->GetMoney() -
                      (customizeActions[actionId].Amount * GOLD));
  } else { // Item
    Item *pItem =
        pPlayer->GetItemByEntry(std::abs(customizeActions[actionId].Amount));
    if (!pItem)
      return false;

    pPlayer->DestroyItem(pItem->GetBagSlot(), pItem->GetSlot(), true);
  }

  return true;
}

uint32 Npc_Customize::proceedAction(Player *pPlayer, uint32 actionId) {
  // Prefix
  actionId -= GOSSIP_ACTION_INFO_DEF;

  // Take money
  if (!checkAndTakeCurrency(pPlayer, actionId))
    return NPC_TEXT_CANNOT_PURCHASE;

  PreparedStatement *stmt =
      CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);

  switch (customizeActions[actionId].Action) {
  case GOSSIP_ACTION_CHANGE_FACTION: {
    stmt->setUInt16(0, uint16(AT_LOGIN_CHANGE_FACTION));
    pPlayer->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
  } break;

  case GOSSIP_ACTION_CHANGE_RACE: {
    stmt->setUInt16(0, uint16(AT_LOGIN_CHANGE_RACE));
    pPlayer->SetAtLoginFlag(AT_LOGIN_CHANGE_RACE);
  } break;

  case GOSSIP_ACTION_CHANGE_CHAR: {
    stmt->setUInt16(0, uint16(AT_LOGIN_CUSTOMIZE));
    pPlayer->SetAtLoginFlag(AT_LOGIN_CUSTOMIZE);
  } break;

  case GOSSIP_ACTION_CHANGE_NAME: {
    stmt->setUInt16(0, uint16(AT_LOGIN_RENAME));
    pPlayer->SetAtLoginFlag(AT_LOGIN_RENAME);
  } break;

  default:
    return NPC_TEXT_ERROR;
  }

  stmt->setUInt32(1, pPlayer->GetGUIDLow());
  CharacterDatabase.Execute(stmt);

  pPlayer->GetSession()->LogoutRequest(time(NULL) + 1);
  return NPC_TEXT_SUCCESS;
}

void AddSC_CS_Customize() { new Npc_Customize(); }