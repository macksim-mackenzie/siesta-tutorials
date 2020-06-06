#  SIESTA shell functions
#
#    Leandro Seixas
#    MackGraphe - Graphene and Nanomaterials Research Center
#    Mackenzie Presbyterian University
#

function siesta_getlastforce() {
  grep constrained job.out | awk '{print $2}' | tail -n 1
}

function siesta_getforces() {
  grep constrained job.out | awk '{print $2}'
}

function siesta_getenergy() {
  grep "Total =" job.out | cut -d = -f 2
}

function siesta_gettemperature() {
  grep "Temp_ion" job.out | cut -d = -f 2
}

function siesta_clean() {
 rm -f H_DMGEN *.bib DM* *.ion* MMpot.* INPUT_TMP.* fdf* Rho.grid.nc FORCE_STRESS CLOCK OCCS BASIS_* NON_TRIMMED_* H_MIXED PARALLEL_DIST pkg.dat pkf.dat MESSAGES CLOCK *.BONDS *.BONDS_FINAL *.TOCH
}

function run_siesta_serial() {
   OMP_NUM_THREADS=1 siesta < input.fdf > job.out &
}
