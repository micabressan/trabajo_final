@SubscribeEvent
	@SideOnly(Side.CLIENT)
	public static void onRenderGameOverlay(RenderGameOverlayEvent.Pre event) {
		Minecraft mc = Minecraft.getMinecraft();
		FontRenderer fr = mc.fontRenderer;
		
		if (mc.player.isSneaking() || mc.currentScreen == null && mc.player.getHeldItemMainhand() != ItemStack.EMPTY && mc.player.getHeldItemMainhand().getItem() instanceof ItemWallet || Minecraft.getMinecraft().currentScreen == null && Minecraft.getMinecraft().player.getHeldItemOffhand() != ItemStack.EMPTY && Minecraft.getMinecraft().player.getHeldItemOffhand().getItem() instanceof ItemWallet) {
			if (event.getType() != ElementType.EXPERIENCE) {
				return;
			}

			String physicalAmount = CurrencyUtils.getAllCurrency(mc.player);
			String accountAmount = mc.player.getCapability(Currency.ACCOUNT_DATA, null).getFormattedAmount();
			
			int position = ConfigHandler.position;
			position = 0;
			
			GL11.glPushMatrix();
			
			if (position == 0 || position == 2) {
				if (position == 2) {
					GL11.glTranslated(0, new ScaledResolution(mc).getScaledHeight() - (34), 0);
				}
				GL11.glPushMatrix();
				GL11.glScaled(3, 3, 0);
				RenderItem renderItem = Minecraft.getMinecraft().getRenderItem();
				ItemStack dollarBill = new ItemStack(ItemHandler.dollarBill);
				GL11.glTranslated(1, -2.5, 0);
				renderItem.renderItemIntoGUI(dollarBill, 0, 0);
				GL11.glPopMatrix();
				
				fr.drawString("Physical: " + physicalAmount, (3 * 16) + 7, 8, 0x37A537);
				fr.drawString("Physical: " + physicalAmount, (3 * 16) + 6, 7, 0x55FF55);
				
				fr.drawString("Account: " + accountAmount, (3 * 16) + 7, 20, 0x37A537);
				fr.drawString("Account: " + accountAmount, (3 * 16) + 6, 19, 0x55FF55);
			} else if (position == 1 || position == 3) {
				if (position == 3) {
					GL11.glTranslated(0, new ScaledResolution(mc).getScaledHeight() - (34), 0);
				}
				GL11.glTranslated(new ScaledResolution(mc).getScaledWidth() - 180, 0, 0);
				GL11.glPushMatrix();
				GL11.glScaled(3, 3, 0);
				RenderItem renderItem = Minecraft.getMinecraft().getRenderItem();
				ItemStack dollarBill = new ItemStack(ItemHandler.dollarBill);
				GL11.glTranslated(1, -2.5, 0);
				renderItem.renderItemIntoGUI(dollarBill, 42, 0);
				GL11.glPopMatrix();
				
				fr.drawString("Physical: " + physicalAmount, (128 - fr.getStringWidth("Physical: " + physicalAmount)), 8, 0x37A537);
				fr.drawString("Physical: " + physicalAmount,  (127 - fr.getStringWidth("Physical: " + physicalAmount)), 7, 0x55FF55);
				
				fr.drawString("Account: " + accountAmount, (128 - fr.getStringWidth("Account: " + accountAmount)), 20, 0x37A537);
				fr.drawString("Account: " + accountAmount, (127 - fr.getStringWidth("Account: " + accountAmount)), 19, 0x55FF55);
			}
			
			GL11.glPopMatrix();
		}
	}