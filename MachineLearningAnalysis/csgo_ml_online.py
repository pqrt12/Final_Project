import pandas as pd
import pickle
import numpy as np
import sys

## filenames
res_dir = '../Resources/'
template_filename = 'template.csv'
lr_model_filename = 'lr_model.pkl'
svm_model_filename = 'svm_model.pkl'
rf_classifier_filename = 'rf_classifier.pkl'

# input template and model
temp_X_df = pd.read_csv(res_dir + template_filename)
temp_X_df


# #### last one counts
# load LR model
with open(res_dir + lr_model_filename, 'rb') as fd:
    model = pickle.load(fd)

'''
# load SVM model
with open(res_dir + svm_model_filename, 'rb') as fd:
    model = pickle.load(fd)# load RandomForest Classifier
with open(res_dir + rf_classifier_filename, 'rb') as fd:
    model = pickle.load(fd)
# ### comment out in production
'''

def debug_print(*args):
    print(args)

# get the model input df
def get_X(team1, team2):
    t1 = 'team_1_' + team1
    t2 = 'team_2_' + team2

    cnt = 0
    x = [0] * temp_X_df.shape[1]
    for i, col_name in enumerate(temp_X_df.columns):
        if (t1 == col_name) or (t2 == col_name):
            x[i] = 1
            cnt += 1
    if cnt == 2:
        return pd.DataFrame(data=[x], dtype=np.int8, columns=temp_X_df.columns)
    return temp_X_df

# internal ML_predict
def ML_predict_(team1, team2):
    if (len(team1) == 0) or (len(team2) == 0):
        print(f"invalid inputs: '{team1}', '{team2}'")
        return {}

    # normal try
    X = get_X(team1, team2)
    if X.shape[0]:
        # get the winning probability
        p_pred = model.predict_proba(X)
        p = p_pred[0]
        res = {team1 : p[0], team2: p[1]}
        return res

    # work harder? => swapping team order
    X = get_X(team2, team1)
    if X.shape[0]:
        # get the winning probability
        p_pred = model.predict_proba(X)
        p = p_pred[0]
        # p_pred swapped !!!
        res = {team1 : p[1], team2: p[0]}
        print(f"swapping teams order: '{team1}', '{team2}'")
        return res

    print(f"cannot find team pair: '{team1}', '{team2}'")
    return {team1 :0.5, team2: 0.5}

# public API
def ML_predict(team1, team2):
    res = ML_predict_(team1, team2)
    debug_print(f'result: {res}')
    return res

