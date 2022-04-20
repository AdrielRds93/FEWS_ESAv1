import sys
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.dates import DateFormatter

# script receives csv file with GEFS data as the first argument, GFS data as second argument and the name of the png file as third argument
filename1 = sys.argv[1]		#GEFS data
filename2 = sys.argv[2]		#GFS data
filenameOut = sys.argv[3] 	#png file out
listOfNamesGEFS = ['DateTime','P000','P020','P050','P080','P100']
listOfNamesGFS = ['DateTime','PGFS']

#read GEFS 3 hourly data - 15 days horizon
dataGEFS = pd.read_csv(filename1, names = listOfNamesGEFS, skiprows=2, na_values = '-999')
datesGEFS = pd.to_datetime(dataGEFS.DateTime, format='%Y-%m-%d %H:%M:%S')

#include GFS hourly data - 5 days horizon
dataGFS = pd.read_csv(filename2, names = listOfNamesGFS, skiprows=2, na_values = '-999')
datesGFS = pd.to_datetime(dataGFS.DateTime, format='%Y-%m-%d %H:%M:%S')

#initialize plots and number of steps to display in GEFS
fig, ax = plt.subplots(1,1, figsize=(6,4))
lastvalue = 3*10

#precipitation
ax.fill_between(datesGEFS[0:lastvalue], dataGEFS.P000[0:lastvalue], dataGEFS.P100[0:lastvalue], facecolor='blue', alpha=0.2, label='min/max')
ax.fill_between(datesGEFS[0:lastvalue], dataGEFS.P080[0:lastvalue], dataGEFS.P020[0:lastvalue], facecolor='blue', alpha=0.5, label='20/80')
ax.plot(datesGEFS[0:lastvalue], dataGEFS.P050[0:lastvalue], color='blue', label='average')
#ax.bar(datesGFS[0:lastvalue], dataGFS.PGFS[0:lastvalue], color='darkblue', alpha=0.8, width=0.0415, align='edge', label='GFS')

#aspect for all subplots
fontsize = 8
date_form = DateFormatter("%d-%m")
ax.set_ylabel('Precipitation [mm]', fontsize=fontsize)
ax.grid(linestyle='--')
ax.xaxis.set_major_formatter(date_form)
ax.legend(loc='upper left', fontsize=fontsize)

#display/save plot
plt.tight_layout() 
plt.savefig(filenameOut) 
#plt.show()

