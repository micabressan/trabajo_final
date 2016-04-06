@Mod(modid = BlockCompressor.MODID, name = BlockCompressor.MODID, version = BlockCompressor.VERSION)
public class BlockCompressor
{
    public static final String MODID = "Compressor";
    public static final String VERSION = "1.0";
    
    //@Instance("BlockCompressor")
    public static BlockCompressor instance = new BlockCompressor();
    //@Instance("BlockCompressor")
    //public static BlockCompressor instance;
    
    @SidedProxy(clientSide="com.swittman.compressor.ClientProxy", serverSide="com.swittman.compressor.ServerProxy")
    public static CommonProxy proxy;
    
    @EventHandler
    public void preInit(FMLPreInitializationEvent e) {
        proxy.preInit(e);
    }

    @EventHandler
    public void init(FMLInitializationEvent e)
    {
    	proxy.init(e);
    	NetworkRegistry.INSTANCE.registerGuiHandler(BlockCompressor.instance, new ModGuiHandler());
    }
    
    @EventHandler
    public void postInit(FMLPostInitializationEvent e) {
        proxy.postInit(e);
    }
    
}