package tk.remceau.gui;

import net.minecraft.server.v1_12_R1.ChatClickable;
import net.minecraft.server.v1_12_R1.ChatComponentText;
import net.minecraft.server.v1_12_R1.ChatModifier;
import net.minecraft.server.v1_12_R1.EnumChatFormat;
import net.minecraft.server.v1_12_R1.IChatBaseComponent;
import tk.remceau.player.XPlayer;
import tk.remceau.player.permissions.Permission;

import java.util.ArrayList;
import java.util.List;

public final class BookBuilder {

    private final List<String> pages = new ArrayList<>();
    private final XPlayer player;
    private int currentPage = 1;

    public BookBuilder() {
        this.player = null;
    }
    public BookBuilder(XPlayer player) {
        this.player = player;
    }

    public BookBuilder addSimplePage(String header, String content) {
        pages.add(IChatBaseComponent.ChatSerializer.a(new ChatComponentText("")
                .addSibling(new ChatComponentText(header).addSibling(new ChatComponentText(":\n\n")).setChatModifier(new ChatModifier().setColor(EnumChatFormat.GOLD).setBold(true)))
                .addSibling(new ChatComponentText(content).setChatModifier(new ChatModifier().setColor(EnumChatFormat.GRAY)))
        ));
        currentPage++;
        return this;
    }
    public BookBuilder addListPage(String header, Object... list) {
        IChatBaseComponent component = new ChatComponentText("").addSibling(new ChatComponentText(header).addSibling(new ChatComponentText(":\n\n")).setChatModifier(new ChatModifier().setColor(EnumChatFormat.GOLD).setBold(true)));
        for (int i = 0; i < list.length; i += 2)
            component.addSibling(new ChatComponentText(String.valueOf(list[i])).addSibling(new ChatComponentText("\n")).setChatModifier(new ChatModifier().setColor(EnumChatFormat.GRAY).setChatClickable(new ChatClickable(ChatClickable.EnumClickAction.CHANGE_PAGE, String.valueOf(list[i + 1])))));
        pages.add(IChatBaseComponent.ChatSerializer.a(component));
        currentPage++;
        return this;
    }
    public BookBuilder addCommandPage(String command, String description, Permission permission, String usage) {
        pages.add(IChatBaseComponent.ChatSerializer.a(new ChatComponentText("")
                .addSibling(new ChatComponentText(command).addSibling(new ChatComponentText(":\n\n")).setChatModifier(new ChatModifier().setColor(EnumChatFormat.GOLD).setBold(true)))
                .addSibling(new ChatComponentText("Description:\n").setChatModifier(new ChatModifier().setColor(EnumChatFormat.DARK_GRAY)))
                .addSibling(new ChatComponentText(description).addSibling(new ChatComponentText("\n\n")).setChatModifier(new ChatModifier().setColor(EnumChatFormat.GRAY)))
                .addSibling(new ChatComponentText("Permission:\n").setChatModifier(new ChatModifier().setColor(EnumChatFormat.DARK_GRAY)))
                .addSibling(asComponent(permission).addSibling(new ChatComponentText("\n\n")))
                .addSibling(new ChatComponentText("Usage:\n").setChatModifier(new ChatModifier().setColor(EnumChatFormat.DARK_GRAY)))
                .addSibling(new ChatComponentText(usage).setChatModifier(new ChatModifier().setColor(EnumChatFormat.GRAY)))
        ));
        currentPage++;
        return this;
    }

    public final Book build() {
        return new Book(pages.toArray(new String[pages.size()]));
    }

    public final int getCurrentPage() {
        return currentPage;
    }

    private IChatBaseComponent asComponent(Permission permission) {
        if (player == null || permission == null)
            return new ChatComponentText("")
                    .addSibling(new ChatComponentText("none").setChatModifier(new ChatModifier().setColor(EnumChatFormat.GRAY)));
        else if (player.hasPermission(permission))
            return new ChatComponentText("")
                    .addSibling(new ChatComponentText("\u2714 ").setChatModifier(new ChatModifier().setColor(EnumChatFormat.GREEN)))
                    .addSibling(new ChatComponentText(permission.name).setChatModifier(new ChatModifier().setColor(EnumChatFormat.GRAY)));
        else
            return new ChatComponentText("")
                    .addSibling(new ChatComponentText("\u2716 ").setChatModifier(new ChatModifier().setColor(EnumChatFormat.RED)))
                    .addSibling(new ChatComponentText(permission.name).setChatModifier(new ChatModifier().setColor(EnumChatFormat.GRAY)));
    }

}