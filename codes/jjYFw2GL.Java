if (skill.hasEffects() && target.getFirstEffect(L2EffectType.BLOCK_DEBUFF) == null)
				{
					List<L2Effect> effects;
					if ((reflect & Formulas.SKILL_REFLECT_SUCCEED) != 0) // reflect skill effects
					{
						activeChar.stopSkillEffects(skill.getId());
						skill.getEffects(target, activeChar);
						activeChar.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.YOU_FEEL_S1_EFFECT).addSkillName(skill));
					}
					else
					{
						if (target.getFirstEffect(skill.getId()) == null)
						{		
							//does not have the effect => apply it							
							effects = skill.getEffects(activeChar, target, new Env(shld, false, false, false));							
							if (effects != null && !effects.isEmpty())
								target.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.YOU_FEEL_S1_EFFECT).addSkillName(skill));		
						}
						else 
						{
							//already has the effect of this certain skill
							//if it's paralysis then resist it because we don't chain paralysis
							//if it's another pdam we pass it along to getEffects which will apply the effect after removing previous effects from this particulat skillID
							if (skill.getEffectType() == L2SkillType.PARALYZE) //only mdam skill we don't chain
							{
								if (activeChar instanceof Player)
									activeChar.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.S1_RESISTED_YOUR_S2).addCharName(target).addSkillName(skill));
							}
							else
							{							
								effects = skill.getEffects(activeChar, target, new Env(shld, false, false, false));							
								if (effects != null && !effects.isEmpty())
									{
									
									target.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.YOU_FEEL_S1_EFFECT).addSkillName(skill));									
									}
								
							}
						}	
					}
				}