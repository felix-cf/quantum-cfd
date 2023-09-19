# Quantum Computing for Computational Fluid Dynamics

## Variational Quantum Linear Solver
VQLS Pennylane, Qiskit, and Cirq folders all contain implementations of the VQLS in their respective frameworks. I did the most work in Qiskit and have results of runs using mostly the COBYLA optimizer. I began using Cirq for the sake of using IonQ's Debiasing and Sharpen noise mitigation techniques. I used Pennylane for the sake of ease of implementing the local cost function as opposed to the global cost function. The current, most updated Notebook is the VQLS_Class_Pennylane notebook, which contains a class that implements the Pennylane framework for quantum circuits to facilitate the analysis of algorithms as they scale up with condition number, error, and system size. Also, it allows for switching out the kinds of matrices being tested, for example, the Ising Problem matrix, the Poisson Equation matrix, etc.

**Currently working on:** 

https://github.com/felix-cf/quantum-cfd/blob/main/VQLS%20Pennylane/VQLS_Class_Pennylane.ipynb

**Relevant papers:**

https://arxiv.org/abs/1909.05820
https://repository.tudelft.nl/islandora/object/uuid:deba389d-f30f-406c-ad7b-babb1b298d87?collection=education


## HHL 
HHL is another algorithm for solving linear systems with quantum computers, but not suited for the Noisy Intermediate Stage Quantum era of quantum computers. 


