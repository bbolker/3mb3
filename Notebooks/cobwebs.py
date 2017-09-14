import matplotlib
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.collections import LineCollection

def cobweb(fun, x0=1, parms=None, nt=20, maxval=None):
    fancy_cobweb(fun, x0 = (x0,), parms = (parms,), nt=nt, maxval=maxval)
    return(None)

def fancy_cobweb(fun, x0=(1,), parms=(None,),nt=20, maxval=None):
    ## assemble a list of lists of tuples
    lines = []
    traj = []
    nlines = max(len(x0),len(parms))
    if len(x0)==1 and nlines>1:
        x0 = (x0[0] for i in range(nlines))
    if len(parms)==1 and nlines>1:
        parms = (x0[0] for i in range(nlines))
    if maxval==None:
        maxval = x0[0]
    ## compute cobweb segments for each starting point/parameter set
    for i in range(len(x0)):
        x = x0[i]
        lines.append([])
        traj.append([])
        for j in range(nt):
            traj[i].append(x)
            fx = fun(x)
            lines[i].extend([(x,x),(x,fx),(fx,fx)])
            x = fx
            if x>maxval:
                maxval = x
    ## create plot
    fig, (axcob, axtraj)  = plt.subplots(1,2,sharey=True)
    lc = matplotlib.collections.LineCollection(lines)
    ## compute f(x) over the range
    xvec = np.linspace(0,maxval,100)
    fxvec = fun(xvec)
    axcob.plot(xvec,fxvec,c="red")  ## f(x)
    axcob.plot(xvec,xvec,c="black") ## 1-to-1 line
    axcob.set_xlim(0,maxval)
    axcob.set_ylim(0,maxval)
    axtraj.set_ylim(0,maxval)
    axcob.add_collection(lc)        ## cobweb segments
    ## plot trajectory
    axtraj.plot(range(nt),traj[0])
    return(None)
