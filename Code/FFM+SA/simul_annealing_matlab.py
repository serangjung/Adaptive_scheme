import neal
import numpy as np
import pandas as pd
import timeit
import dwave.inspector

def d_simul(filename):
    start_time = timeit.default_timer()
    
    file = open(filename+'_qubo_qlm.txt', 'r')
    bias_file = np.loadtxt(filename+'_bias.txt')
    
    A = file.read()
    A = np.asmatrix(A)
    m = int(np.size(A)**(1/2))
    A = np.reshape(A, (m,m))
    
    var_off=bias_file.astype(float)
    
    Q = np.zeros(np.shape(A))
    Q = A
    
    
    sampler = neal.SimulatedAnnealingSampler()
    sampleset=sampler.sample_qubo(Q, num_reads=100, num_sweeps=1000,beta_schedule_type="geometric")
    
    terminate_time = timeit.default_timer()
    
    
    
    print(Q)
    print('--------------------------------------------------------------')
    print(sampleset)
    
    print("calculation: %fsec." % (terminate_time - start_time))
    
    
    
    df = pd.DataFrame(sampleset)
    df.to_csv('simul_output.txt', header = None, index = False, sep = '\t')
    
    
    file = open('simul_output.txt', 'r')
    sampleset = file.read()
    sampleset = np.asmatrix(sampleset)
    sampleset = np.reshape(sampleset, (-1, m))
    print("This is sampleset \n")
    
    print(sampleset)
    print("This is sampleset \n")
    
    OptimizedData = sampleset[0, :]
    df = pd.DataFrame(OptimizedData)
    df.to_csv('simul_OptimizedData.txt', header = None, index = False, sep = ' ')

    
    FOM = (OptimizedData*Q*OptimizedData.T +var_off)
    df = pd.DataFrame(FOM)
    df.to_csv('simul_FOM.txt', header = None, index = False, sep = '\t')
 
    
    print("Optimized Structure: \n", OptimizedData)
    print("FOM: ", FOM)
