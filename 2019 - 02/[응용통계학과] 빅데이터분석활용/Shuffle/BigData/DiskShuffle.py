import pandas as pd
import numpy as np
#import os

def disk_shuffle(filename_in, filename_out, header=True, CHUNK_SIZE = 5000, SEP=','):
    with open(filename_out, 'a') as W:
        with open(filename_in, 'r') as R:
            iterator = pd.read_csv(R, chunksize=CHUNK_SIZE)
            for n, df in enumerate(iterator):
                if n==0 and header:
                    df.iloc[np.random.permutation(len(df))].to_csv(W, index=False, header=True, sep=SEP)
                else :
                    df.iloc[np.random.permutation(len(df))].to_csv(W, index=False, header=False, sep=SEP)

    
#local_path = os.getcwd() + os.sep
local_path = 'D:/BigData/'
source = 'bikesharing/hour.csv'
fileName_in = local_path + source
fileName_out = local_path + 'bikesharing/hour_DiskShuffled.csv'
CHUNK_SIZE = 1000

disk_shuffle(fileName_in, fileName_out, header=True, CHUNK_SIZE = 10000, SEP=',')
    