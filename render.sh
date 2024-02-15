#!/bin/bash

# IPs
## find available render machines at subnet
subnet="192.168.56"
## expected range of host machines
hosts=$(seq 13 14)

# SCAN by IP using ping
## declare an empty array of reachble IPs
declare -a reachable=()
count=0

for host in $hosts; do
	## assemble ip
	ip="${subnet}.${host}"

	## ping once, wait for 1 second, no stdout, returns 0 of successful
	if ping -c 1 -W 1 "$ip" > /dev/null; then
		echo "[OK] Host $ip is reachable."

		## count reachable machines and add to array
        ((count++))
		reachable+=("$ip")
	else
		echo "[  ] Host $ip is unreachable!"
	fi
done

# prepare the output folder
mkdir render-output

# UI
echo "> Name of .blend file?:"
read name
echo "> How many frames?:"
read frames
echo "> output directory: ./render-output/"
echo "> logs written into: ./render-output/"

# PATH to target .blend file (insert NAS here)
path_to_blend_file="blender-test/$name.blend"

# LOGS
echo -e "Starting render.sh script at $(date '+%Y-%m-%d %H:%M:%S'), by $USER ...\n" > render-output/network-scan.log
echo -e "Starting render.sh script at $(date '+%Y-%m-%d %H:%M:%S'), by $USER ...\n" > render-output/render-job.log
echo -e "Starting render.sh script at $(date '+%Y-%m-%d %H:%M:%S'), by $USER ...\n" > render-output/shell-stdout.log
echo -e "List of $count reachable IPs:\n" >> render-output/network-scan.log
echo -e "Distributing $frames frames among $count machines:\n" >> render-output/render-job.log
echo -e "Shell stdout:\n" >> render-output/shell-stdout.log
for ip in ${reachable[@]}; do
	echo "	> $ip" >> render-output/network-scan.log
done

# RENDER JOB
## calculate batch size for each machine
batch=$(( 1 + frames / count ))
i=0
echo "> sending jobs..."
for ip in ${reachable[@]}; do
	## end variable solves even/odd frames division issue (max function)
	end=$(( frames < batch + i * batch ? frames : batch + i * batch ))
    
	## prepare a command to send to machine at $ip
	render_command="xvfb-run -a blender -b $path_to_blend_file -o //render-output/$name -F PNG -s $(( 1 + i * batch)) -e $end -a"
    ((i++))

    ## sends the command $render_command to $ip machine and log
	ssh fj@$ip $render_command >> render-output/shell-stdout.log &
	echo "ssh fj@$ip $render_command" >> render-output/render-job.log
done