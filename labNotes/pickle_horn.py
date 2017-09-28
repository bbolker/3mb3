import re
import numpy as np
import pickle
import pandas as pd

f = open("horn.txt", "r")
tmp = pd.read_csv(f,delim_whitespace=True)
res = np.array(tmp)
M = np.array(res).transpose()/100
abbrevs = np.array(tmp.columns.values)
names = np.array(tmp.index,"str")
outf = open("horn.pkl","wb")
pickle.dump((names,abbrevs,M),outf)

