@SubscribeEvent
	@SideOnly(Side.CLIENT)
	public void onRenderGameOverlay(RenderGameOverlayEvent.Post event)
	{
		if(Minecraft.getMinecraft().player.isSneaking() || Minecraft.getMinecraft().currentScreen == null && Minecraft.getMinecraft().player.getHeldItemMainhand() != ItemStackTools.getEmptyStack()
				&& Minecraft.getMinecraft().player.getHeldItemMainhand().getItem() instanceof ItemWallet || Minecraft.getMinecraft().currentScreen == null && Minecraft.getMinecraft().player.getHeldItemOffhand() != ItemStackTools.getEmptyStack()
				&& Minecraft.getMinecraft().player.getHeldItemOffhand().getItem() instanceof ItemWallet)
		{
			if(event.getType() != ElementType.ALL)
			{
				return;
			}

			ConfigHandler.position = 0;

			RenderHelper tessellator = RenderHelper.getInstance();
			FontRenderer fr = Minecraft.getMinecraft().fontRendererObj;

			GL11.glEnable(GL11.GL_BLEND);
			GL11.glPushMatrix();
			{
				int offset = 0;

				if(fr.getStringWidth("Physical: " + CurrencyUtils.getAllCurrency(Minecraft.getMinecraft().player)) > fr.getStringWidth("Account: "
						+ Minecraft.getMinecraft().player.getCapability(Currency.ACCOUNT_DATA, null).getFormattedAmount()))
				{
					offset = fr.getStringWidth("Physical: " + CurrencyUtils.getAllCurrency(Minecraft.getMinecraft().player));
				}
				else
				{
					offset = fr.getStringWidth("Account: " + Minecraft.getMinecraft().player.getCapability(Currency.ACCOUNT_DATA, null).getFormattedAmount());
				}

				ScaledResolution scale = new ScaledResolution(Minecraft.getMinecraft());

				int addNum = 2;

				if(ConfigHandler.position == 4)
				{
					addNum = 0;

					GL11.glTranslated(scale.getScaledWidth() / 2, 3, 0);
				}

				if(ConfigHandler.position == 0 || ConfigHandler.position == 2)
				{
					GL11.glTranslated(51 / 2 + 0.5, 0, 0);
				}

				if(ConfigHandler.position == 1 || ConfigHandler.position == 3)
				{
					GL11.glTranslated(scale.getScaledWidth() + (51) + (-offset - 51 - 3), 0, 0);
					GL11.glTranslated(offset - 25.5, 0, 0);
				}

				int s = 49;
				GL11.glTranslatef(0, -11, 0);

				if(ConfigHandler.position == 2 || ConfigHandler.position == 3)
				{
					GL11.glTranslated(0, scale.getScaledHeight() - 32, 0);
				}

				GL11.glTranslated(-25.5, 0, 0);
				tessellator.startDrawing(GL11.GL_QUADS);
				{
					GL11.glColor4f(1, 1, 1, 1F);
					Minecraft.getMinecraft().renderEngine.bindTexture(new ResourceLocation(ModInfo.MODID + ":textures/items/dollar_bill.png"));

					tessellator.addVertexWithUV(addNum + 0, addNum + 0, 0, 0, 0);
					tessellator.addVertexWithUV(addNum + 0, addNum + s, 0, 0, 1);
					tessellator.addVertexWithUV(addNum + s, addNum + s, 0, 1, 1);
					tessellator.addVertexWithUV(addNum + s, addNum + 0, 0, 1, 0);
				}
				tessellator.draw();
				GL11.glTranslated(25.5, 0, 0);

				if(ConfigHandler.position == 4)
				{

				}

				if(ConfigHandler.position == 0 || ConfigHandler.position == 2)
				{
					GL11.glTranslated(-51 / 2 + 0.5, 0, 0);

					fr.drawString("Physical: " + CurrencyUtils.getAllCurrency(Minecraft.getMinecraft().player), s + 4, 16, ColorHelper.getDecimalFromRGB(255, 255, 255), true);

					fr.drawString("Account: " + Minecraft.getMinecraft().player.getCapability(Currency.ACCOUNT_DATA, null).getFormattedAmount(), s + 4, 29,
							ColorHelper.getDecimalFromRGB(255, 255, 255), true);
				}
				else if(ConfigHandler.position == 1 || ConfigHandler.position == 3)
				{
					GL11.glTranslated(-51 / 2 + 0.5 - 2, 0, 0);

					GL11.glTranslated(-offset + 25.5, 0, 0);
					GL11.glTranslated(-fr.getStringWidth("Physical: " + CurrencyUtils.getAllCurrency(Minecraft.getMinecraft().player)), 0, 0);

					fr.drawString("Physical: " + CurrencyUtils.getAllCurrency(Minecraft.getMinecraft().player), s + 4, 16, ColorHelper.getDecimalFromRGB(255, 255, 255), true);

					GL11.glTranslated(fr.getStringWidth("Physical: " + CurrencyUtils.getAllCurrency(Minecraft.getMinecraft().player)), 0, 0);
					GL11.glTranslated(-fr.getStringWidth("Account: " + Minecraft.getMinecraft().player.getCapability(Currency.ACCOUNT_DATA, null).getFormattedAmount()), 0, 0);

					fr.drawString("Account: " + Minecraft.getMinecraft().player.getCapability(Currency.ACCOUNT_DATA, null).getFormattedAmount(), s + 4, 29,
							ColorHelper.getDecimalFromRGB(255, 255, 255), true);

					GL11.glTranslated(fr.getStringWidth("Account: " + Minecraft.getMinecraft().player.getCapability(Currency.ACCOUNT_DATA, null).getFormattedAmount()), 0, 0);
				}
				else if(ConfigHandler.position == 4)
				{
					GL11.glTranslated(0, -3, 0);

					fr.drawString("Physical: " + CurrencyUtils.getAllCurrency(Minecraft.getMinecraft().player),
							-fr.getStringWidth("Physical: " + CurrencyUtils.getAllCurrency(Minecraft.getMinecraft().player)) / 2 - 1, 16 + 25.5F + 2, ColorHelper.getDecimalFromRGB(255, 255, 255),
							true);

					fr.drawString("Account: " + Minecraft.getMinecraft().player.getCapability(Currency.ACCOUNT_DATA, null).getFormattedAmount(),
							-fr.getStringWidth("Account: " + Minecraft.getMinecraft().player.getCapability(Currency.ACCOUNT_DATA, null).getFormattedAmount()) / 2, 29 + 25.5F + 2,
							ColorHelper.getDecimalFromRGB(255, 255, 255), true);
				}
			}
			GL11.glPopMatrix();
			GL11.glDisable(GL11.GL_BLEND);
		}
	}