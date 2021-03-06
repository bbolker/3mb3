import matplotlib
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.collections import LineCollection

def logistfun(x,parms=(3.5,)):
    '''logistic function
    '''
    r, = parms  ## unpack parameters
    return(r*x*(1-x))
    
def bifurc(fun, parm_range, baseparms,
           parm_ind, x0=0.5, nt=1000, nt_keep=100):
    '''generate data for a (1-dimensional) bifurcation diagram
    fun: function fun(x,parms) taking a state variable and a tuple of parameters
    parm_range: an iterable (tuple/list) of parameter values to evaluate
    baseparms: tuple of baseline values of parameters
    parm_ind: parameter index; index within baseparms to vary
    x0: initial conditions
    nt: total number of time steps
    nt_keep: number of time steps to retain (out of nt)
    '''
    res = np.zeros((len(parm_range),nt_keep))
    for i in range(len(parm_range)):
        p = parm_range[i]
        cur_p = list(baseparms)
        cur_p[parm_ind] = p
        cur_p = tuple(cur_p) ## maybe unnec
        cur_res = []
        x = x0
        for t in range(nt):
            x = fun(x,cur_p)
            if t>=(nt-nt_keep):
                cur_res.append(x)
        res[i,:] = cur_res
    return(res)
    


if __name__=="__main__":
    pr = np.arange(0.1,4,0.025)
    b0 = bifurc(logistfun, parm_range=pr, baseparms=(2,),
                parm_ind=0)
    plt.plot(pr,b0,'ro',c='black',markersize=2)
