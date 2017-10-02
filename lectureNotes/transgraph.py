## thanks to http://matthiaseisen.com/articles/graphviz/
import graphviz as gv

def transmat_to_graph(M,node_labs,edge_labs=None,format="png"):
    """construct state diagram/transition graph from transition matrix
    M: numpy array
    node_labs: array of node labels
    edge_labs: "flows" to add numeric values of flows
       (could add an option where edge_labs was a 2-D string array?)
    format: output format for rendered graph 
    """
    g = gv.Digraph(format=format)
    for n in node_labs:
        g.node(n)
    for i in range(M.shape[0]):
        for j in range(M.shape[1]):
            if M[i,j] != 0:
                if edge_labs=="flows":
                    g.edge(node_labs[j],node_labs[i],
                           label = str(M[i,j]))
                else:
                    g.edge(node_labs[j],node_labs[i])
    return(g)

if __name__=="__main__":
    import pickle
    f = open("horn.pkl","rb")
    names,abbrevs,M = pickle.load(f)
    g0 = transmat_to_graph(M,abbrevs)
    g1 = transmat_to_graph(M,abbrevs,edge_labs="flows")
    g1.render()
