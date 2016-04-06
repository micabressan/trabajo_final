package com.FisheyLP.Utils;

import org.bukkit.Bukkit;
import org.bukkit.Location;

public class LocationUtils {

	public static String serialize(Location loc) {
		return loc.getWorld().getName()+":"+loc.getX()+":"+loc.getY()+":"+loc.getZ();
	}
	public static String serializeFully(Location loc) {
		return serialize(loc)+":"+loc.getYaw()+":"+loc.getPitch();
	}
	
	public static Location deserialize(String str) {
		Location loc = new Location(null, 0, 0, 0);
		String[] split = str.split(":");
		loc.setWorld(Bukkit.getWorld(split[0]));
		loc.setX(Double.parseDouble(split[1]));
		loc.setY(Double.parseDouble(split[2]));
		loc.setZ(Double.parseDouble(split[3]));
		return loc;
	}
	public static Location deserializeFully(String str) {
		Location loc = deserialize(str);
		String[] split = str.split(":");
		loc.setYaw(Float.parseFloat(split[4]));
		loc.setPitch(Float.parseFloat(split[5]));
		return loc;
	}
}