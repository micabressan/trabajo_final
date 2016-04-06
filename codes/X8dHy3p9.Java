package derelanadeCode.lostzone.common.network;

import cpw.mods.fml.common.eventhandler.SubscribeEvent;
import cpw.mods.fml.common.network.FMLEventChannel;
import cpw.mods.fml.common.network.FMLNetworkEvent.ClientCustomPacketEvent;
import cpw.mods.fml.common.network.FMLNetworkEvent.ServerCustomPacketEvent;
import cpw.mods.fml.common.network.NetworkRegistry.TargetPoint;
import cpw.mods.fml.common.network.internal.FMLProxyPacket;
import cpw.mods.fml.relauncher.Side;
import cpw.mods.fml.relauncher.SideOnly;

import java.util.Hashtable;
import java.util.Map;

import derelanadeCode.lostzone.LDEngine;
import derelanadeCode.lostzone.common.network.AbstractPacket;
import derelanadeCode.lostzone.common.network.packet.LDConsumeInventoryAmmo;
import derelanadeCode.lostzone.common.network.packet.LDGetEntityIDPacket;
import derelanadeCode.lostzone.common.network.packet.LDGunSkinFixPacket;
import derelanadeCode.lostzone.common.network.packet.LDHitMarkerPacket;
import derelanadeCode.lostzone.common.network.packet.LDOpenGuiPacket;
import derelanadeCode.lostzone.common.network.packet.LDPacketSyncPlayerProps;
import derelanadeCode.lostzone.common.network.packet.LDParticlesSpawnPacket;
import derelanadeCode.lostzone.common.network.packet.LDPickUpItem;
import derelanadeCode.lostzone.common.network.packet.LDPickupItemPacket;
import derelanadeCode.lostzone.common.network.packet.LDPlaySoundPacket;
import derelanadeCode.lostzone.common.network.packet.LDSetAttachmentToWeapon;
import derelanadeCode.lostzone.common.network.packet.LDSetItemToInventory;
import derelanadeCode.lostzone.common.network.packet.LDSetWeaponSkinPacket;
import derelanadeCode.lostzone.common.network.packet.LDSyncEntityInventory;
import derelanadeCode.lostzone.common.network.packet.LDSyncInventory;
import derelanadeCode.lostzone.common.network.packet.LDThirdPersonView;
import derelanadeCode.lostzone.common.network.packet.LDUpdateMeleeWeaponTexture;
import derelanadeCode.lostzone.common.network.packet.LDWeaponLaserPacket;
import derelanadeCode.lostzone.common.network.packet.LDWeaponRecoilPacket;
import derelanadeCode.lostzone.common.network.packet.LDWeaponReloadPacket;
import net.minecraft.client.Minecraft;
import net.minecraft.entity.Entity;
import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.entity.player.EntityPlayerMP;
import net.minecraft.network.NetHandlerPlayServer;

public class LDPacketHandeler {

   public Map map = new Hashtable();
   public Map channels = new Hashtable();


   public LDPacketHandeler() {
      this.map.put("LD | CIA", new LDConsumeInventoryAmmo());
      this.map.put("LD | OGP", new LDOpenGuiPacket());
      this.map.put("LD | SPP", new LDPacketSyncPlayerProps());
      this.map.put("LD | PSP", new LDPlaySoundPacket());
      this.map.put("LD | SATW", new LDSetAttachmentToWeapon());
      this.map.put("LD | SI", new LDSyncInventory());
      this.map.put("LD | TPV", new LDThirdPersonView());
      this.map.put("LD | WRP", new LDWeaponReloadPacket());
      this.map.put("LD | WLP", new LDWeaponLaserPacket());
      this.map.put("LD | SITI", new LDSetItemToInventory());
      this.map.put("LD | WRCP", new LDWeaponRecoilPacket());
      this.map.put("LD | PUI", new LDPickUpItem());
      this.map.put("LD | PSP2", new LDParticlesSpawnPacket());
      this.map.put("LD | PIP", new LDPickupItemPacket());
      this.map.put("LD | SWSP", new LDSetWeaponSkinPacket());
      this.map.put("LD | GEIDP", new LDGetEntityIDPacket());
      this.map.put("LD | SEI", new LDSyncEntityInventory());
      this.map.put("LD | HMP", new LDHitMarkerPacket());
      this.map.put("LD | UMWT", new LDUpdateMeleeWeaponTexture());
      this.map.put("LD | GSFP", new LDGunSkinFixPacket());
   }

   @SubscribeEvent
   public void onServerPacket(ServerCustomPacketEvent event) {
	   //
      ((AbstractPacket)this.map.get(event.packet.channel())).processServer(event.packet.payload(), ((NetHandlerPlayServer)event.handler).playerEntity);
   }

   @SubscribeEvent
   public void onClientPacket(ClientCustomPacketEvent event) {
      ((AbstractPacket)this.map.get(event.packet.channel())).processClient(event.packet.payload(), this.getClientPlayer());
   }

   @SideOnly(Side.CLIENT)
   private EntityPlayer getClientPlayer() {
      return Minecraft.getMinecraft().thePlayer;
   }

   public void sendTo(FMLProxyPacket packet, EntityPlayerMP player) {
      ((FMLEventChannel)this.channels.get(packet.channel())).sendTo(packet, player);
   }

   public void sendPacketToServer(FMLProxyPacket packet) {
	   //
      ((FMLEventChannel)this.channels.get(packet.channel())).sendToServer(packet);
   }

   public void sendPacketAround(Entity entity, double range, FMLProxyPacket packet) {
	   //
      ((FMLEventChannel)this.channels.get(packet.channel())).sendToAllAround(packet, new TargetPoint(entity.dimension, entity.posX, entity.posY, entity.posZ, range));
   }

   public void sendPacketToAll(FMLProxyPacket packet) {
      ((FMLEventChannel)this.channels.get(packet.channel())).sendToAll(packet);
   }
}