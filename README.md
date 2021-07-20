Selfish mining sim
-------------------
Written with Python 2

To run experiments from scratch:
bash experiments.sh
bash data_cleanup.sh

To generate graphs from existing data from repo:
bash data_cleanup.sh


File descriptions:

data_cleanup.sh - used to combine output data from different gamma experiments (0, 0.5, 1)
	
	- combine_gammas.sh - used for experiments when adding additional hash power
	
	- no_add_hash_combine_gammas.sh - used for experiments (ISM) that don't add additional hash power
	
	- create_graphs.gp - uses gnuplot to generate pdf graphs

Test descriptions:

whole - only collects data at the end of runs; default tests alpha from 0.01 to 0.5 in 0.01 increments
timestep - collects data at every block; default only test alphas 0.1, 0.33, 0.49

