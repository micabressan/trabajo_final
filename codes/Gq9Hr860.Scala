package Paradygmaty_lab_list_9;

import java.util.ArrayList;

public class CLevelOfGraph<V, S>
{
    public int iCalcLevelOfGraph(CGraph<V, S> pcGraph)
    {
        ArrayList<V> c_list_of_vertices = pcGraph.cGetVertices();

        int i_tab_of_degree[] = new int[c_list_of_vertices.size()];

        for(int ii = 0 ; ii < i_tab_of_degree.length; ii++)
            i_tab_of_degree[ii] = 0;

        int i_max_degree = 0;

        for (int ij = 0; ij < c_list_of_vertices.size(); ij++)
        {
            V c_act_vertex = c_list_of_vertices.get(ij);
            ArrayList<V> pc_list_of_neigh = pcGraph.cGetEdges(c_act_vertex);

            for(int ii=0; ii < pc_list_of_neigh.size(); ii++)
            {
                i_tab_of_degree[ij]++;
                i_tab_of_degree[c_list_of_vertices.indexOf((V) pc_list_of_neigh.get(ii))]++;
            } // for(int ii=0; ii < pc_list_of_neigh.size(); ii++)
        } // for (int ij = 0; ij < c_list_of_vertices.size(); ij++)

        for (int ii=0; ii< i_tab_of_degree.length; ii++)
        {
            int i_act_degree = i_tab_of_degree[ii];

            if( i_act_degree > i_max_degree)
                i_max_degree = i_act_degree;
        } // for (int ii=0; ii< i_tab_of_degree.length; ii++)

        return i_max_degree;
    } // public int iCalcLevelOfGraph(CGraph<V,S>)
} // public static class LevelOfGraph<V,S>