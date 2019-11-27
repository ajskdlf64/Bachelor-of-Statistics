import csv, math
import pandas as pd
import matplotlib.pyplot as plt
# import os

class StreamStat:
    def __init__(self, fileName, feature, title):
        self.fileName = fileName
        self.feature = feature
        self.title = title
        
    def meanStd(self):
        running_mean = list()
        running_std = list()

        with open(self.fileName, 'r') as R:
            iterator = csv.DictReader(R, delimiter=',')    
            first = next(iterator)
            m = float(first[self.feature])
            s = 0.
            running_mean.append(m)
            running_std.append(s)
        
            for n, row in enumerate(iterator):
                n = n + 2
                x = float(row[self.feature])
                s = s + (1. - 1./n) * (x - m) * (x - m)
                m = ((n-1) * m + x)/n
                running_mean.append(m)
                running_std.append(math.sqrt(s/(n-1)))
            
        return(pd.DataFrame({'mean': running_mean, 'std': running_std}))
    
    def plot(self):
#        
        data = StreamStat.meanStd(self)
        minY = min(data.min())
        maxY = max(data.max())
        
        plt.plot(data['mean'],'r-', label='mean')
        plt.plot(data['std'], 'b-', label='standard deviation')
        plt.title(self.title)
        plt.ylim(minY-0.1, maxY+ 0.05)
        plt.xlabel('Number of training examples')
        plt.ylabel('Value')
        plt.legend(loc='lower right', numpoints= 1)
        plt.grid(True)
        plt.show()        
        

#local_path = os.getcwd() + os.sep
local_path = 'D:/BigData/'

original = local_path + 'bikesharing/hour.csv'
shuffled = local_path + 'bikesharing/hour_RamShuffled.csv'
disk_shuffled = local_path + 'bikesharing/hour_DiskShuffled.csv'

nonShuff = StreamStat(original, 'temp', "Original Data")
nonShuff.plot()

shuff = StreamStat(shuffled, 'temp', "Ram Shuffed Data")
shuff.plot()

Dshuff = StreamStat(shuffled, 'temp', "Disk Shuffed Data")
Dshuff.plot()

