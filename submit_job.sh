# sbatch --wait job.sh
JOBID="$(sbatch job.sh)"
echo $JOBID
if [[ $JOBID =~ ([0-9]+) ]]; then
    JOBID=${BASH_REMATCH[1]}
fi
while :
do
    OUTPUT=$(squeue -j $JOBID)
    echo $OUTPUT
    if [[ "$(echo $OUTPUT | grep PHI3)" == "" ]]; then
        break
    else
        sleep 1
    fi
done