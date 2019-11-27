import pandas as pd
import numpy as np
#import os

def ram_Shuffle(filename_in, filename_out, header=True, SEP=','):
    
    with open(filename_in, 'r') as R:
        data = pd.read_csv(R, sep = SEP)

    with open(filename_out, 'w') as W:
        data.iloc[np.random.permutation(len(data))].to_csv(W, index=False, header = header, sep=SEP)
    
# local_path = os.getcwd() + os.sep
        
local_path = 'D:/BigData/'
source = 'bikesharing/hour.csv'
fileName_in = local_path + source
fileName_out = local_path + 'bikesharing/hour_RamShuffled.csv'

ram_Shuffle(fileName_in, fileName_out, header=True)
    
        
