### FROM PREVIOUS LECTURE ....
print "IMPORTING MODULES..."
import pandas as pd
import numpy as np

df = pd.read_csv('https://dl.dropboxusercontent.com/u/28535341/IE_MBD_FA_dataset_dev.csv')

import re
list_inputs = set()
for var_name in df.columns:
    if re.search('^i',var_name):
        list_inputs.add(var_name)
        print var_name,"is input binary"
    elif re.search('^o',var_name):
        output_var = var_name
        print var_name,"is output (target) binary"


### PART 1 - FITTING DecisionTreeClassifier MODEL WITH ALL INPUT VARIABLE IN THE DEVELOPMENT DATASET - it requires output variable to be binary

X = df[list(set(list_inputs))]
y = df[output_var]

from sklearn import tree
clf = tree.DecisionTreeClassifier()
clf = clf.fit(X,y)

#WE CAN VISUALISE THE TREE USING A PROGRAM LIKE XDOT!
with open("fraud.dot", 'w') as f:
    f = tree.export_graphviz(clf, out_file=f)

# BUT I RECOMMEND TO INTALL pydot (sudo apt-get python-pydot) AND GENERATE PDFs!
from sklearn.externals.six import StringIO
import pydot 
dot_data = StringIO() 
tree.export_graphviz(clf, out_file=dot_data) 
graph = pydot.graph_from_dot_data(dot_data.getvalue())
graph.write_pdf("fraud.pdf") 

# PART 2- FITTING A DecisionTreeRegressor INSTEAD - it considers the output to be continuos instead of binary
from sklearn import tree
clf = tree.DecisionTreeRegressor()
clf = clf.fit(X, y)

import pydot 
dot_data = StringIO() 
tree.export_graphviz(clf, out_file=dot_data) 
graph = pydot.graph_from_dot_data(dot_data.getvalue())
graph.write_pdf("fraud_regression_tree.pdf") 

#### PART 3 - USING A MIN SUPPORT = 50
#min_samples_split=50
from sklearn import tree
clf = tree.DecisionTreeClassifier(min_samples_split=50)
clf = clf.fit(X, y)

from sklearn.externals.six import StringIO
import pydot 
dot_data = StringIO() 
tree.export_graphviz(clf, out_file=dot_data) 
graph = pydot.graph_from_dot_data(dot_data.getvalue())
graph.write_pdf("fraud_50support.pdf") 


### PARt 4 - TRAINING AND VALIDATING
from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3)
print X_train.shape, X_test.shape

from sklearn.metrics import roc_auc_score
for numb in (50,100,150,200,250,300,350,400,450,500):
    clf = tree.DecisionTreeClassifier(min_samples_split=numb)
    clf = clf.fit(X_train,y_train)
    y_pred_train= clf.predict(X_train)
    y_pred_test= clf.predict(X_test)
    gini_train = 2*roc_auc_score(y_train, y_pred_train)-1
    gini_test  = 2*roc_auc_score(y_test, y_pred_test)-1            
    print numb,", gini_train=",gini_train, "gini_test=", gini_test , " relative_diff=", (gini_train - gini_test)/gini_train


