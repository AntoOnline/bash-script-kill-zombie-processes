#!/bin/bash

# Get a list of zombie processes
zombies=$(ps aux | awk '$8 == "Z" { print $2, $11 }')

# Check if there are any zombie processes
if [ -z "$zombies" ]; then
    echo "No zombie processes found."
else
    # Iterate through the list of zombie processes
    while read -r pid process; do
        # Get the parent process ID (PPID)
        ppid=$(ps -o ppid= -p "$pid")

        # Check if the PPID is not empty
        if [ -n "$ppid" ]; then
            # Kill the parent process
            kill -s SIGCHLD "$ppid"

            # Wait for the zombie process to be reaped
            counter=0
            while ps -p "$pid" > /dev/null && [ $counter -lt 5 ]; do
                sleep 1
                counter=$((counter + 1))
            done

            # Check if the zombie process still exists
            if ps -p "$pid" > /dev/null; then
                # Forcibly kill the parent process
                kill -9 "$ppid"
                echo "Forcibly killed parent process: PPID=$ppid"
            fi

            # Echo the killed process details
            echo "Killed zombie process: PID=$pid, Process=$process, PPID=$ppid"
        else
            echo "Unable to find PPID for zombie process: PID=$pid, Process=$process"
        fi
    done <<< "$zombies"
fi
