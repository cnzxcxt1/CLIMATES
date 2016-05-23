# clustering for the 2010 scenarios
import matplotlib as mpl
from matplotlib import pyplot as plt
import numpy as np
from numpy import genfromtxt
from sklearn import linear_model
from sklearn import cross_validation
from sklearn import metrics
from sklearn.metrics import roc_curve, auc
from sklearn.cluster import KMeans
import numpy as np
from matplotlib import cm
from sklearn.metrics import silhouette_samples
import pylab
from sklearn.datasets import make_blobs

import pandas as pd


colors = ['b', 'g', 'r', 'c', 'm', 'y', 'k', 'black']

X = pd.read_csv('C://R_3_0//NASA//2000//TMAX_2000.csv')
#cluster process with Kmeans
km = KMeans(n_clusters=3,
            init='k-means++',
            n_init=100,
            max_iter=1000,
            tol=1e-04,
            random_state=0)
y_km = km.fit_predict(X)



# Using the elbow method to find the optimal number of clusters
