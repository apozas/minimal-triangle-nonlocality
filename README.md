## Code to accompany *[Post-quantum nonlocality in the minimal triangle scenario](https://www.arxiv.org/abs/2304.xxxxx)*
#### Alejandro Pozas-Kerstjens and his friends

This is a repository containing the computational appendix of the article "*Post-quantum nonlocality in the minimal triangle scenario*. Alejandro Pozas-Kerstjens and his friends [arXiv:2304.xxxxx](https://www.arxiv.org/abs/2304.xxxxx)." It provides the codes for obtaining the results depicted in Figures 3 and 4 in the manuscript.

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

  - [plots.ipynb](https://github.com/apozas/minimal-triangle/blob/main/plots.ipynb): Code to generate the plots and additional visualizations.

  - [points_E1E2E3.txt](https://github.com/apozas/minimal-triangle/blob/main/points_E1E2E3.txt): Distributions, characterized by ![](https://latex.codecogs.com/svg.latex?E_1), ![](https://latex.codecogs.com/svg.latex?E_2) and ![](https://latex.codecogs.com/svg.latex?E_3), used for producing the figures.

  - [results/](https://github.com/apozas/minimal-triangle/blob/main/results/): Folder where the results of the calculations are stored.

If you would like to cite this work, please use the following format:

A. Pozas-Kerstjens, and his friends, _Post-quantum nonlocality in the minimal triangle scenario_, arXiv:2304.xxxxx

```
@misc{pozaskerstjens2023minimaltriangle,
  title = {Post-quantum nonlocality in the minimal triangle scenario},
  author = {Pozas-Kerstjens, Alejandro and his friends},
  archivePrefix = {arXiv},
  eprint = {2304.xxxxx}
}
```
