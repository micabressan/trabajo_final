package Paradygmaty_lab_list_9;

import java.util.*;

public  class CGraph<V, S> implements IGraph<V,S>
{
    private ArrayList<V> c_vertex_list;
    private HashMap<V, ArrayList <CPair<V,S>>> c_neigh_list;

    public CGraph(ArrayList<V> cVertexList, HashMap<V, ArrayList <CPair<V,S>>> cNeighList)
    {
        c_vertex_list = cVertexList;
        c_neigh_list = cNeighList;
    } // public CGraph(ArrayList<V> cVertexList, HashMap<V, ArrayList <CPair<V,S>>> cNeighList)

    @Override
    public ArrayList<V> cGetVertices()
    {
        return c_vertex_list;
    }

    @Override
    public S cGetEdge(V cStartVer, V cEndVer)
    {
        ArrayList<CPair<V,S>> c_list;
       if ((c_list = c_neigh_list.get(cStartVer)) != null)
       {
           for (CPair<V,S> c_p : c_list)
           {
               if (c_p.getFirst().equals(cEndVer))
                   return c_p.getSecond();
           }
       }
        return null;
    } // public Object cGetEdge(Object cStartVer, Object cEndVer) {

    @Override
    public ArrayList<V> cGetEdges(V cVer)
    {
        ArrayList<V> pc_score_list = new ArrayList<>();
        for(CPair<V,S> c_p : c_neigh_list.get(cVer))
            pc_score_list.add(c_p.getFirst());
        return  pc_score_list;
    }

} // public  class CGraph<Vertex, Edge> implements IGraph