import matplotlib.pyplot as plt

from ase import Atoms, Atom
from ase.neb import NEBTools
from ase import Atoms
from ase.io import read, write
from ase.visualize import view

images = read('neb.traj@-7:')

write('neb.xyz',images)
nebtools = NEBTools(images)

for i in range(7):
    image = images[i]
    print(image.get_cell())

#get barrier
Ef,dE = nebtools.get_barrier()

#get force
max_force = nebtools.get_fmax()

#Create a figure
fig = nebtools.plot_band()
fig.savefig('phase_transition.png')
