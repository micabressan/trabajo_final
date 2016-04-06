			ItemStack is = new ItemStack(Material.COMPASS);
			ItemMeta im = is.getItemMeta();
			im.setDisplayName("§aNOM DE L'ITEM");
			is.setItemMeta(im);
			p.getInventory().addItem(is);
			p.updateInventory();

			p.getInventory().setItem(0, is);