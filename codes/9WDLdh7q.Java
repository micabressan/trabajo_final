package derelanadeCode.lostzone.common.network.packet;

import cpw.mods.fml.common.network.ByteBufUtils;
import derelanadeCode.lostzone.common.handlers.LDPlayerHandler;
import derelanadeCode.lostzone.common.network.AbstractPacket;
import io.netty.buffer.ByteBuf;
import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.entity.player.EntityPlayerMP;
import net.minecraft.item.ItemStack;

public class LDSyncInventory extends AbstractPacket {

   public boolean check;
   public String player;
   public LDPlayerHandler extendedplayer;
   public int currentItem;


   public LDSyncInventory() {}

   public LDSyncInventory(String player, LDPlayerHandler props, int currentItem) {
      this.player = player;
      this.extendedplayer = props;
      this.currentItem = currentItem;
   }

   public String getChannel() {
      return "LD | SI";
   }

   public void write(ByteBuf buf) {
      ByteBufUtils.writeUTF8String(buf, this.player);
      buf.writeInt(this.currentItem);

      for(int i = 0; this.extendedplayer.player.inventory.mainInventory.length > i; ++i) {
         ByteBufUtils.writeItemStack(buf, this.extendedplayer.player.inventory.mainInventory[i]);
      }

   }

   public void processServer(ByteBuf buf, EntityPlayerMP player) {}

   public void processClient(ByteBuf buf, EntityPlayer player) {
      String name = ByteBufUtils.readUTF8String(buf);
      int currentItem = buf.readInt();
      ItemStack[] itemStack = new ItemStack[36];

      for(int props = 0; itemStack.length > props; ++props) {
         itemStack[props] = ByteBufUtils.readItemStack(buf);
      }

      LDPlayerHandler var8 = LDPlayerHandler.getClientPlayer(name, player);
      if(var8 != null) {
         for(int s = 0; itemStack.length > s; ++s) {
            var8.inventory[s] = itemStack[s];
         }

         var8.currentItem = currentItem;
         LDPlayerHandler.customSlotsData.put(name, var8);
      }
   }
}