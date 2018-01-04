package Paradygmaty_lab_list_9;

import java.util.ArrayList;
import java.util.HashMap;

// 'G' means that not jet all neighbourhoods of vertex are visited
// 'W' means that the vertex is to visit
// 'B' means that all neighbourhoods of vertex are visited



public class CIsGraphCycling<V, S> {
    public boolean bIsCyclic(CGraph<V, S> pcGraph) {
        HashMap<V,Character> c_visited = new HashMap<>();

        ArrayList<V> pc_vertex = pcGraph.cGetVertices();

        for (int ii = 0; ii < pc_vertex.size(); ii++)
            c_visited.put(pc_vertex.get(ii), 'W');

        for (int ii =0; ii < c_visited.size(); ii++)
            if ((c_visited.get(pc_vertex.get(ii)) == 'W') && bISGraphCylic(pcGraph, c_visited, pc_vertex.get(ii)))
                return true;

        return false;
    } // public boolean bIsCycling(CGraph<V,S> pcGraph)

    private  boolean bISGraphCylic(CGraph<V,S> pcGraph, HashMap<V,Character> cVisited, V pcActVer)
    {
        cVisited.put(pcActVer, 'G');

        ArrayList<V> pc_list_of_neigh = pcGraph.cGetEdges(pcActVer);

        while(!pc_list_of_neigh.isEmpty())
        {
            V pc_next = pc_list_of_neigh.remove(0);
            if(cVisited.get(pc_next) == 'G') return true;
            if(((cVisited.get(pc_next)) == 'W') && bISGraphCylic(pcGraph, cVisited, pc_next ))
                return true;
        } // while(!pc_list_of_neigh.isEmpty())
        cVisited.put(pcActVer, 'B');
        return false;
    } // private  boolean bISGraphCylic(CGraph<V,S> pcGraph, int iVer, char[] cVisited)
} // public class CIsGraphCycling <V,S>