@EventHandler
public void BlocCassé(BlockBreakEvent e){
    if(e.getBlock().getType().equals(Material.LOG)){
           arbre(e.getBlock());
    }
}

public void arbre(Block block){
    if(block.getType().equals(Material.LOG) || block.getType().equals(Material.LEAVES)){
        block.breakNaturally();
        for(BlockFace face : BlockFace.values()){
            arbre(block.getRelative(face));
        }
    }
}