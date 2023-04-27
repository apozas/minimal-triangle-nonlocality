# Code for
# Post-quantum nonlocality in the minimal triangle scenario
# arXiv:2305.xxxxx
#
# Authors: Alejandro Pozas-Kerstjens
#
# Requires: inflation for setting up and solving the problems
#           numpy for array operations
# Last modified: May, 2023

import numpy as np
from inflation import InflationProblem, InflationSDP

def prob(E1, E2, E3):
    return np.array([[[[[[1-3*E1+3*E2-E3]]], [[[1-E1-E2+E3]]]],
                      [[[[1-E1-E2+E3]]], [[[1+E1-E2-E3]]]]],
                     [[[[[1-E1-E2+E3]]], [[[1+E1-E2-E3]]]],
                      [[[[1+E1-E2-E3]]], [[[1+3*E1+3*E2+E3]]]]]]) / 8
# Define network
dag = {"h1": ["v1", "v2"],
       "h2": ["v1", "v3"],
       "h3": ["v2", "v3"]}

# Define inflation
InfProb = InflationProblem(dag=dag,
                           outcomes_per_party=[2, 2, 2],
                           settings_per_party=[1, 1, 1],
                           inflation_level_per_source=[3,2,2],
                           verbose=1)

# Define classical (commuting=True) or quantum (commuting=False)
InfSDP = InflationSDP(InfProb, commuting=False, verbose=1)
InfSDP.generate_relaxation('physical2')

E1 = 0
E3 = 0
left = 0
right = 1

while abs(right-left) > 1e-4:
	v = (right + left) /2
	InfSDP.set_distribution(prob(E1, v, E3), use_lpi_constraints=True)
	InfSDP.solve(interpreter='MOSEKFusion', feas_as_optim=True)
	print(f"v={v}, lambda={InfSDP.primal_objective}")
	if InfSDP.primal_objective > 0:
		left = v
	else:
		right = v
