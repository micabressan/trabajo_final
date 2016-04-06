package org.shaymin.nds.text;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.channels.FileChannel.MapMode;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableList.Builder;

public final class TextArchiveDecoder {
	public static void main(String[] args) throws IOException, FileNotFoundException {
		new TextArchiveDecoder();
	}
	
	private TextArchiveDecoder() throws IOException, FileNotFoundException {
		File romsDirectory = new File("roms/");
		if (!romsDirectory.exists()) {
			throw new FileNotFoundException("Could not find roms directory");
		}
		
		File romFile = romsDirectory.listFiles()[0];
		
		try (RandomAccessFile accessedRom = new RandomAccessFile(romFile, "r")) {
			ByteBuffer romBuffer = accessedRom.getChannel().map(MapMode.READ_ONLY, 0, accessedRom.length());
			
			int targetArchiveAddress = 0x21E5000;
			int targetInnerArchiveAddress = 0x4497B8; // Pokemon names
			int startAddress = (targetArchiveAddress + targetInnerArchiveAddress);
			
			romBuffer.position(startAddress);
			romBuffer.order(ByteOrder.LITTLE_ENDIAN);
			
			int fatGoldenMultiplier = 765;
			int payloadGoldenMultiplier = 596947;
			
			int archiveSize = romBuffer.getShort(); // Should be 494, as in 494 names
			int rawGoldenKey = romBuffer.getShort();
			
			int goldenKey = (rawGoldenKey * fatGoldenMultiplier) & 0xFFFF;
			
			int unknownValue = 0;
			int anotherUnknownValue = 0;
			
			int[] stringAddresses = new int[archiveSize];
			int[] stringSizes = new int[archiveSize];
			
			// File allocation table
			
			for (int entryId = 0; entryId < archiveSize; entryId++) {
				unknownValue = (goldenKey * (entryId + 1)) & 0xFFFF;
				anotherUnknownValue = (unknownValue | (unknownValue << 16));
				
				stringAddresses[entryId] = (romBuffer.getInt() ^ anotherUnknownValue);
				stringSizes[entryId] = (romBuffer.getInt() ^ anotherUnknownValue);
			}
			
			// Payload
			
			Builder<String> builder = ImmutableList.builder();
			
			for (int entryId = 0; entryId < archiveSize; entryId++) {
				goldenKey = (payloadGoldenMultiplier * (entryId + 1)) & 0xFFFF;
				
				StringBuilder nameBuilder = new StringBuilder();
				
				for (int stringSizeIdx = 0; stringSizeIdx < stringSizes[entryId]; stringSizeIdx++) {
					int decimalVal = (romBuffer.getShort() ^ goldenKey) & 0xFFFF;
					
					goldenKey += 18749;
					goldenKey &= 65535;
					
					if (decimalVal == 65535) {
						break;
					}
					
					// TODO: look up decimal value in lookup table to replace with ASCII character
					nameBuilder.append(decimalVal);
				}
				
				builder.add(nameBuilder.toString());
			}
			
			ImmutableList<String> names = builder.build();
			
			// do more with your list of names
		}
	}
}