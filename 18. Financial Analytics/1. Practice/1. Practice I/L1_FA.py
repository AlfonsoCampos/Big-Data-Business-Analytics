print "IMPORTING MODULES..."
import pandas as pd
import numpy as np
 
 
df = pd.read_csv('https://dl.dropboxusercontent.com/u/28535341/dev.csv')
 
########################################
# BIVARIATE ANALYSIS = INPUT BINARY    #
########################################
biv = pd.crosstab(df["ib_var_1"],df["ob_target"])
print biv
a= 0.01 # to avoid division by zero
WoE = np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a)) #multiply by 1.0 to transform into float and add "a=0.01" to avoid division by zero.
#WoE = np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1])))
print WoE
IV = sum(((1.0*biv[0]/sum(biv[0])+a) - (1.0*biv[1]/sum(biv[1])+a))*np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a)))
#IV = sum(((biv[0]/sum(biv[0])) - (biv[1]/sum(biv[1])))*np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1]))))
print IV
 
 
########################################
# VARIABLE = INPUT CATEGORICAL NOMINAL #
########################################
biv = pd.crosstab(df["icn_var_22"],df["ob_target"])
print biv
#ob_target     0   1
#icn_var_22         
#1            24   3
#2           378  47
#3            97  10
#4            30   4
 
a= 0.01 # to avoid division by zero
WoE = np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a))
#WoE = np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1])))
print WoE
#icn_var_22
#1            -0.026843
#2            -0.026986
#3             0.151086
#4            -0.083220
 
IV = sum(((1.0*biv[0]/sum(biv[0])+a) - (1.0*biv[1]/sum(biv[1])+a))*np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a)))
#IV = sum(((biv[0]/sum(biv[0])) - (biv[1]/sum(biv[1])))*np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1]))))
print IV
#0.00515373622463
 
 
 
########################################
# VARIABLE = INPUT CATEGORICAL ORDINAL #
########################################
biv = pd.crosstab(df["ico_var_25"],df["ob_target"])
print biv
a= 0.01 # to avoid division by zero
WoE = np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a))
#WoE = np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1])))
print WoE
 
IV = sum(((1.0*biv[0]/sum(biv[0])+a) - (1.0*biv[1]/sum(biv[1])+a))*np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a)))
#IV = sum(((biv[0]/sum(biv[0])) - (biv[1]/sum(biv[1])))*np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1]))))
print IV
 
########################################
# VARIABLE = INPUT CONTINUOS           #
########################################
biv = pd.crosstab(df["if_var_68"],df["ob_target"])
print biv
a= 0.01 # to avoid division by zero
WoE = np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a))
#WoE = np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1])))
 
IV = sum(((1.0*biv[0]/sum(biv[0])+a) - (1.0*biv[1]/sum(biv[1])+a))*np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a)))
#IV = sum(((biv[0]/sum(biv[0])) - (biv[1]/sum(biv[1])))*np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1]))))
print IV
 
 
 
import re
list_inputs = set()
list_outputs = set()
list_ib = set()  #input binary
list_icn = set() #input categorical nominal
list_ico = set() #input categorical ordinal
list_if = set()  #input numerical continuos (input float) 
list_sd = set()  #segment to use for development (=1)
list_sv = set()  #segment for validating in all groups
list_ex = set()  #variable to be exclude
 
for var_name in df.columns:
    if re.search('^ib_',var_name):
        list_inputs.add(var_name)
        list_ib.add(var_name)
        print var_name,"is input binary"
    elif re.search('^icn_',var_name):
        list_inputs.add(var_name)
        list_icn.add(var_name)
        print var_name,"is input categorical nominal"
    elif re.search('^ico_',var_name):
        list_inputs.add(var_name)
        list_ico.add(var_name)
        print var_name,"is input categorical ordinal"
    elif re.search('^if_',var_name):
        list_inputs.add(var_name)
        list_if.add(var_name)
        print var_name,"is input numerical continuos (input float)"
    elif re.search('^ob_',var_name):
        output_var = var_name
        print var_name,"is output (target) binary"
    elif re.search('^ex_',var_name):
        list_ex.add(var_name)
        print var_name,"is a variable to be exclude (not used at all)"
 
print "BINARY" 
for var_name in list_ib:
    biv = pd.crosstab(df[var_name],df["ob_target"])
    print biv
    a= 0.01 # to avoid division by zero
    WoE = np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a)) #multiply by 1.0 to transform into float and add "a=0.01" to avoid division by zero.
    #WoE = np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1])))
    print WoE
    IV = sum(((1.0*biv[0]/sum(biv[0])+a) - (1.0*biv[1]/sum(biv[1])+a))*np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a)))
    #IV = sum(((biv[0]/sum(biv[0])) - (biv[1]/sum(biv[1])))*np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1]))))
    print IV
 
print "NOMINAL"
for var_name in list_icn:
    biv = pd.crosstab(df[var_name],df["ob_target"])
    print biv
    a= 0.01 # to avoid division by zero
    WoE = np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a)) #multiply by 1.0 to transform into float and add "a=0.01" to avoid division by zero.
    #WoE = np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1])))
    print WoE
    IV = sum(((1.0*biv[0]/sum(biv[0])+a) - (1.0*biv[1]/sum(biv[1])+a))*np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a)))
    #IV = sum(((biv[0]/sum(biv[0])) - (biv[1]/sum(biv[1])))*np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1]))))
    print IV
 
print "ORDINAL"
for var_name in list_ico:
    biv = pd.crosstab(df[var_name],df["ob_target"])
    print biv
    a= 0.01 # to avoid division by zero
    WoE = np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a)) #multiply by 1.0 to transform into float and add "a=0.01" to avoid division by zero.
    #WoE = np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1])))
    print WoE
    IV = sum(((1.0*biv[0]/sum(biv[0])+a) - (1.0*biv[1]/sum(biv[1])+a))*np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a)))
    #IV = sum(((biv[0]/sum(biv[0])) - (biv[1]/sum(biv[1])))*np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1]))))
    print IV
 
print "CONTINUOUS"
for var_name in list_if:
    biv = pd.crosstab(df[var_name],df["ob_target"])
    print biv
    a= 0.01 # to avoid division by zero
    WoE = np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a)) #multiply by 1.0 to transform into float and add "a=0.01" to avoid division by zero.
    #WoE = np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1])))
    print WoE
    IV = sum(((1.0*biv[0]/sum(biv[0])+a) - (1.0*biv[1]/sum(biv[1])+a))*np.log((1.0*biv[0]/sum(biv[0])+a) / (1.0*biv[1]/sum(biv[1])+a)))
    #IV = sum(((biv[0]/sum(biv[0])) - (biv[1]/sum(biv[1])))*np.log((biv[0]/sum(biv[0])) / (biv[1]/sum(biv[1]))))
    print IV
 

