import graphviz as gv

def transmat_to_graph(M,nodelabs,edge_vals,format="png"):
    g = gv.Digraph(format=format)
    for n in nodelabs:
        g.node(n)
    for i in range(M.shape[0]):
        for j in range(M.shape[1]):
            if M[i,j] != 0:
                g.edge(nodelabs[i],nodelabs[j])
    return(g)

if __name__=="__main__":
    import pickle
    f = open("horn.pkl","rb")
    names,abbrevs,M = pickle.load(f)
    
