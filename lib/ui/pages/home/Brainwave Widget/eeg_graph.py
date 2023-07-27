# generate_eeg_graph.py
import matplotlib.pyplot as plt
import numpy as np
import json
def generate_eeg_graph_data():
    y = np.loadtxt("assets\data\EEGraw-1.txt")
    flm = 512
    L = len(y)
    Y = np.fft.fft(y)
    Y[0] = 0
    P2 = np.abs(Y / L)
    P1 = P2[:L // 2 + 1]
    P1[1:-1] = 2 * P1[1:-1]
    f1 = (np.arange(len(P1)) * flm / len(P1)) / 2
    indices1 = np.where((f1 >= 0.5) & (f1 <= 50))[0]
    indices2 = indices1 / indices1[len(indices1) - 1] * 50

    # Save the EEG graph data to a file
    data = {'indices': indices2.tolist(), 'values': P1[indices1].tolist()}
    json_string = json.dumps(data)
    return json_string