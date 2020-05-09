#!/bin/bash


mysql -u root -p -B -N -e "SHOW STATUS LIKE 'Uptime'"
	