#!/bin/bash

open() {
    local -r script=$(readlink -f $0)
    sudo -Es bash -ci "bash "$script" "$use_switch""
}


use() {
	local -r theip="$(get_ip)"

	source "/home/idein/.bashrc" \
    && cd "/home/idein/realsense-ros_ws/install" \
    && echo -e "\nCurrent IP (required to reach ROS over the network!): "$theip"\n\n\n" \
    && export ROS_IP="$theip" \
    && roslaunch ./share/realsense2_camera/launch/rs_camera.launch; \
    bash
}


get_ip() {
	local -r network_interface="eth0"
	local -r theip="$(/sbin/ip -4 -o addr show dev "$network_interface"| awk '{split($4,a,"/");print a[1]}')"
	
	echo "$theip"
}


run() {
	readonly use_switch="use"

	if [[ "$#" -eq 0 ]]; then # Gar nichts übergeben
		open
	elif [[ "$1" == "$use_switch" ]]; then # "use" übergeben
		use
	else
		open # Etwas anderes übergeben
	fi
}


run "$@"

