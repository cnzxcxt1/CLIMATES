import matplotlib as mpl
from matplotlib import pyplot as plt
import numpy as np
from sklearn import linear_model
from sklearn import metrics
from sklearn.cluster import KMeans
import pylab
import pandas as pd


colors = ['b', 'g', 'r', 'c', 'm', 'y', 'k', 'black']
  
variables=["TMIN","TMAX","RG","P","ET"]

X = pd.read_csv('C://R_3_0//720scaleddata.csv')
X.shape
    
# Using the elbow method to find the optimal number of clusters
# while using SSE (distortion) to do the clustering.
# the some of suqared distance between each instant and its cluster center
sillhouette_avgs = [] 
distortions = []
for i in range(3, 30):
    km = KMeans(n_clusters=i,
                init='k-means++',
                n_init=1000,
                max_iter=10000,
                random_state=0)
    kmean=km.fit(X)
    sillhouette_avgs.append(metrics.silhouette_score(X, kmean.labels_))
    distortions.append(km.inertia_)
    
plt.plot(range(3,30), distortions, marker='o')
plt.xlabel('Number of clusters')
plt.ylabel('Distortion')
#plt.title('elbow for ')
plt.show()    
    
plt.plot(range(3,30), sillhouette_avgs, marker='o')
plt.xlabel('Number of clusters')
plt.ylabel('silhouette')
plt.show()

