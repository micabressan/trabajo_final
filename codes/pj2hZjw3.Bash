#!/bin/bash
#
#gromacs with acpype

#Assuming stanting file is istarting with pdb ID
file=$(file *_fix.pdb | head -c 4)
lig=$(grep "^HETATM" ${file}_fix.pdb | tail -n 1 | awk '{print $4}')

# Assuming Complex.pdb (= 1BVG.pdb), split it in Protein.pdb and ${lig}.pdb
# wget -c "http://www.pdb.org/pdb/download/downloadFile.do?fileFormat=pdb&compression=NO&structureId=1BVG" -O 1BVG.pdb
grep 'ATOM  ' ${file}_fix.pdb>| Protein.pdb
#jau yra:
grep 'HETATM' ${file}_fix.pdb>| ${lig}.pdb

\cp Protein.pdb ProteinAmber.pdb

# Process with pdb2gmx and define water
/scratch/lustre/home/vyra6599/bin/gromacs-4.6.7/build/src/kernel/pdb2gmx_mpi -ff amber99sb -f ProteinAmber.pdb -o Protein2.pdb -p Protein.top -water spce -ignh || exit 1

# Generate ${lig} topology file with acpype (GAFF)
#acpype -i ${lig}.pdb

# Merge Protein2.pdb + updated ${lig}_NEW.pdb -> Complex.pdb
grep -h ATOM Protein2.pdb ${lig}.acpype/${lig}_NEW.pdb >| Complex.pdb

# Edit Protein.top -> Complex.top
\cp ${lig}.acpype/${lig}_GMX.itp ${lig}.itp
\cp Protein.top Complex.top

# #include "${lig}.itp" has to be inserted right after ffamber**.itp line and before Protein_*.itp line in Complex.top. 

cat Complex.top | sed "/forcefield\.itp\"/a\
#include \"${lig}.itp\"
" >| Complex2.top

echo "${lig}   1" >> Complex2.top
\mv Complex2.top Complex.top

# Setup the box and add water
/scratch/lustre/home/vyra6599/bin/gromacs-4.6.7/build/src/tools/editconf_mpi -bt triclinic -f Complex.pdb -o Complex.pdb -d 1.0 || exit 1
/scratch/lustre/home/vyra6599/bin/gromacs-4.6.7/build/src/tools/genbox_mpi -cp Complex.pdb -cs spc216.gro -o Complex_b4ion.pdb -p Complex.top || exit 1

# Create em.mdp file
cat << EOF >| em.mdp
define                   = -DFLEXIBLE
integrator               = cg ; steep
nsteps                   = 200
constraints              = none
emtol                    = 1000.0
nstcgsteep               = 10 ; do a steep every 10 steps of cg
emstep                   = 0.01 ; used with steep
nstcomm                  = 1
coulombtype              = PME
ns_type                  = grid
rlist                    = 1.0
rcoulomb                 = 1.0
rvdw                     = 1.4
Tcoupl                   = no
Pcoupl                   = no
gen_vel                  = no
nstxout                  = 0 ; write coords every # step
optimize_fft             = yes
EOF

# Create md.mdp file
cat << EOF >| md.mdp
integrator               = md
nsteps                   = 5000000 ; 10 ns
dt                       = 0.002
constraints              = all-bonds
nstcomm                  = 1
ns_type                  = grid
rlist                    = 1.2
rcoulomb                 = 1.1
rvdw                     = 1.0
vdwtype                  = shift
rvdw-switch              = 0.9
coulombtype              = PME-Switch
Tcoupl                   = v-rescale
tau_t                    = 0.1 0.1
tc-grps                  = protein non-protein
ref_t                    = 300 300
Pcoupl                   = parrinello-rahman
Pcoupltype               = isotropic
tau_p                    = 0.5
compressibility          = 4.5e-5
ref_p                    = 1.0
gen_vel                  = yes
nstxout                  = 2 ; write coords every # step
lincs-iter               = 2
DispCorr                 = EnerPres
optimize_fft             = yes
EOF

# Setup ions
/scratch/lustre/home/vyra6599/bin/gromacs-4.6.7/build/src/kernel/grompp_mpi -f em.mdp -c Complex_b4ion.pdb -p Complex.top -o Complex_b4ion.tpr || exit 1
\cp Complex.top Complex_ion.top

# neber -norandom tokios tai istrinta
echo 15| /scratch/lustre/home/vyra6599/bin/gromacs-4.6.7/build/src/tools/genion_mpi -s Complex_b4ion.tpr -o Complex_b4em.pdb -neutral -conc 0.15 -p Complex_ion.top || exit 1

\mv Complex_ion.top Complex.top

/scratch/lustre/home/vyra6599/bin/gromacs-4.6.7/build/src/kernel/grompp_mpi -f em.mdp -c Complex_b4em.pdb -p Complex.top -o em.tpr || exit 1

# Create min.job file
cat << EOF >| min.job
#!/bin/tcsh
#SBATCH -p long
#SBATCH -n12
#SBATCH -t 02-00:00
/scratch/lustre/home/vyra6599/bin/gromacs-4.6.7/build/src/kernel/mdrun_mpi -deffnm em
EOF


# Create sim.job file
cat << EOF >| sim.job
#!/bin/tcsh
#SBATCH -p verylong
#SBATCH -n12
#SBATCH -t 02-00:00
/scratch/lustre/home/vyra6599/bin/gromacs-4.6.7/build/src/kernel/grompp_mpi -f md.mdp -c em.gro -p Complex.top -o md.tpr
/scratch/lustre/home/vyra6599/bin/gromacs-4.6.7/build/src/kernel/mdrun_mpi -deffnm md
EOF