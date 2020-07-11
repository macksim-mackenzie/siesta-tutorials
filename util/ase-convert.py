import matplotlib.pyplot as plt
from ase.io import read, write

images = read('MoS2-initial.traj@-7:')

write('initial.xyz',images)
