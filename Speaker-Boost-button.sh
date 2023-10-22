#!/bin/bash

#############################################################################
# Speaker-Boost-button.sh
#
# This script can be used if you have a speaker in your show and don't want 
# to play loud music all the time. You can have a button the audience can 
# press to trigger this script.
#
# You can change the volume by simply adjusting the START_VOLUME and PEAK_VOLUME
# constants.
#
# By: Emil Johansen
#############################################################################

# Lock file path
lock_file="/tmp/SpeakerBoostLockfile.lock"

# Check if the script is already running
if [ -e "${lock_file}" ]; then
    echo "The script is already running."
    exit 0
fi

# Create lock file
touch "${lock_file}"

#############################################################################
# ONLY CHANGE THE NUMBERS AND VALUES BETWEEN THE ###
#
# Volume at the beginning and end:
readonly START_VOLUME=30  # e.g., 30% volume

# Volume at peak:
readonly PEAK_VOLUME=70   # e.g., 70% volume

# Time the audio is at peak
# 5s = Wait 5 seconds
# 5m = Wait 5 minutes
# 5h = Wait 5 hours
readonly PEAK_TIME="5s"

# Speed of the volume change (not defined in seconds):
readonly STEP=2           # e.g., change by 2% each step
#############################################################################

# Validate parameters
if [ $START_VOLUME -ge $PEAK_VOLUME ]; then
    echo "Start volume should be less than peak volume."
    exit 1
fi

# Function to adjust the volume
adjust_volume() {
    local start=$1
    local end=$2
    local step=$3

    if [ $step -gt 0 ]; then
        for ((i=start; i<=end; i+=step)); do
            echo "Setting volume to $i"
            /opt/fpp/src/fpp -v $i
        done
    else
        for ((i=start; i>=end; i+=step)); do
            echo "Setting volume to $i"
            /opt/fpp/src/fpp -v $i
        done
    fi
}

# Main logic
# Increase volume to peak level
adjust_volume $START_VOLUME $PEAK_VOLUME $STEP

# Keep volume at peak level for the specified time
echo "Keeping volume at peak level for ${PEAK_TIME}"
sleep $PEAK_TIME

# Decrease volume back to the start level
adjust_volume $PEAK_VOLUME $START_VOLUME "-$STEP"

# Remove lock file at the end
rm -f "${lock_file}"

# FADE OUT (You can add additional logic here if needed)
