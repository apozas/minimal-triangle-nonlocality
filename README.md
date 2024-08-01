[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7912221.svg)](https://doi.org/10.5281/zenodo.7912221)

## Code to accompany *[Post-quantum nonlocality in the minimal triangle scenario](https://www.arxiv.org/abs/2305.03745)*
#### Alejandro Pozas-Kerstjens, Antoine Girardin, Tamás Kriváchy, Armin Tavakoli, and Nicolas Gisin

This is a repository containing the computational appendix of the article "*Post-quantum nonlocality in the minimal triangle scenario*. Alejandro Pozas-Kerstjens, Antoine Girardin, Tamás Kriváchy, Armin Tavakoli, and Nicolas Gisin. [New J. Phys. 25, 113037 (2023)](https://doi.org/10.1088/1367-2630/ad0a16) ([arXiv:2305.03745](https://www.arxiv.org/abs/2305.03745))." It provides the codes for obtaining the results depicted in Figures 3 and 4 in the manuscript.

The code is written in Python and MATLAB.

Python libraries required:
- [matplotlib](https://matplotlib.org) for plots
- [numpy](https://www.numpy.org) for math operations
- [inflation](https://www.github.com/ecboghiu/inflation) (and its requirements) for setting up and solving the inflation problems

MATLAB libraries required:
- [textprogressbar](https://github.com/megasthenis/textprogressbar) for progress bars (can be easily removed from the code)

Files:

  - [LP/bisection.m](https://github.com/apozas/minimal-triangle/blob/main/LP/bisection.m): Bisection code for obtaining the values corresponding to classical inflations in Figure 4.

  - [LP/compute_compatibility.m](https://github.com/apozas/minimal-triangle/blob/main/LP/compute_compatibility.m): Code for assessing whether a distribution given by ![](https://latex.codecogs.com/svg.latex?E_1), ![](https://latex.codecogs.com/svg.latex?E_2) and ![](https://latex.codecogs.com/svg.latex?E_3) admits a triangle-local or triangle-NSI model. This code is used for creating the data for Figure 3.

  - [LP/XXXinflationYYY](https://github.com/apozas/minimal-triangle/blob/main/LP/): Implementations of different inflations of the triangle scenario. Currently: [HexagonInflation](https://github.com/apozas/minimal-triangle/blob/main/LP/HexagonInflation.m), [WebInflation222](https://github.com/apozas/minimal-triangle/blob/main/LP/WebInflation222.m), [WebInflation322](https://github.com/apozas/minimal-triangle/blob/main/LP/WebInflation322.m), [WebInflation332](https://github.com/apozas/minimal-triangle/blob/main/LP/WebInflation332.m).

  - [SDP/bisection.py](https://github.com/apozas/minimal-triangle/blob/main/SDP/bisection.py): Bisection code for obtaining the values corresponding to quantum inflations and large classical inflations in Figure 4.

  - [boundary_E1E2E3.txt](https://github.com/apozas/minimal-triangle/blob/main/boundary_E1E2E3.txt): Distributions, characterized by ![](https://latex.codecogs.com/svg.latex?E_1), ![](https://latex.codecogs.com/svg.latex?E_2) and ![](https://latex.codecogs.com/svg.latex?E_3), that lie in the boundary between distributions identified as triangle-nonlocal via inflation and those not identified.
  
  - [plots.ipynb](https://github.com/apozas/minimal-triangle/blob/main/plots.ipynb): Code to generate the plots and additional visualizations.

  - [points_E1E2E3.txt](https://github.com/apozas/minimal-triangle/blob/main/points_E1E2E3.txt): Distributions, characterized by ![](https://latex.codecogs.com/svg.latex?E_1), ![](https://latex.codecogs.com/svg.latex?E_2) and ![](https://latex.codecogs.com/svg.latex?E_3), used for producing the figures in the manuscript.

  - [results](https://github.com/apozas/minimal-triangle/blob/main/results/): Folder where the results of the calculations are stored.

If you would like to cite this work, please use the following format:

A. Pozas-Kerstjens, A. Girardin, T. Kriváchy, A. Tavakoli, and N. Gisin, _Post-quantum nonlocality in the minimal triangle scenario_, New J. Phys. **25**, 113037 (2023), arXiv:2305.03745

```
@article{pozaskerstjens2023minimaltriangle,
  doi = {10.1088/1367-2630/ad0a16},
  url = {https://dx.doi.org/10.1088/1367-2630/ad0a16},
  month = {nov},
  publisher = {IOP Publishing},
  volume = {25},
  number = {11},
  pages = {113037},
  author = {Alejandro Pozas-Kerstjens and Antoine Girardin and Tamás Kriváchy and Armin Tavakoli and Nicolas Gisin},
  title = {Post-quantum nonlocality in the minimal triangle scenario},
  journal = {New J. Phys.},
  archivePrefix = {arXiv},
  eprint = {2305.03745},
  year = {2023}
}
```
