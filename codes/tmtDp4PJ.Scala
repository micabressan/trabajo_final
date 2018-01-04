def build_dependency_graph(word,I):
    G=nx.DiGraph()
    add_all_dependence_edges(G,word,I)        
    remove_redundant_dependencies(G)
    node_labels= build_labels(word)
  
    G2=nx.relabel_nodes(G,node_labels)
    return G2


def add_all_dependence_edges(G,word,I):
    for node,label in enumerate(word[:-1]):
        for node2,label2 in list(enumerate(word))[node+1:]:
            if not (label,label2) in I:
                G.add_edge(node,node2)

                
def remove_redundant_dependencies(G):
    def multiple_paths_present(paths):
        return len(paths)>1
    
    for start_node in range(len(G.nodes)-1):
        for end_node in range(start_node+1,len(G.nodes)):
            paths= list(nx.all_simple_paths(G,start_node,end_node))
            if multiple_paths_present(paths):
                direct_paths = list(filter(lambda x: len(x)==2,paths))
                if not empty(direct_paths):
                    n1,n2= direct_paths[0]
                    G.remove_edge(n1,n2)
                        
def build_labels(word):
    node_labels={}
    label_counter={}
    for l in word:
        label_counter[l]=0

    for i,label in enumerate(word):
        node_labels[i]="{}{}".format(label,label_counter[label])
        label_counter[label]+=1
    return node_labels