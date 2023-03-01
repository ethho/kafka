#!/bin/bash
set -e

# Necessary to conda activate my-env
# source /home/eho/miniconda3/etc/profile.d/conda.sh

# Defaults

# Parse command line args
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
	case $1 in
		-e|--extension)
			EXTENSION="$2"
			shift # past argument
			shift # past value
			;;
		-s|--searchpath)
			SEARCHPATH="$2"
			shift # past argument
			shift # past value
			;;
		--default)
			DEFAULT=YES
			shift # past argument
			;;
		-*|--*)
			echo "Unknown option $1"
			exit 1
			;;
		*)
			POSITIONAL_ARGS+=("$1") # save positional arg
			shift # past argument
			;;
	esac
done
set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

# Capture stdin
# input="$(< /dev/stdin)"

# Logging function
# Usage: _log 'this is my message!' [ debug | info | '' | warn | error ]
function _log {
	_level=${2}
	_term=0
	case ${_level} in
		d|deb|debug)
			color='0;34'
			;;
		''|i|info)
			color='0'
			;;
		w|warn|warning)
			color='0;33'
			;;
		e|err|error)
			color='0;31'
			_term=1
			;;
		*)
			echo "ERROR: invalid logging level: ${_level}"
			exit 1
			;;
	esac
	printf "\e[${color}m${1}\e[m\n"
	if [[ ${_term} == '1' ]]; then
		exit 1
	fi
}

# ------------------------------------------------------------------------------

nohup sleep 10 &
ps -A | grep sleep
sleep 15
ps -A | grep sleep


# # Build jar
# ./gradlew jar

# # Initialize Kafka (separate terminal sessions)
# # Log to logs/server.loc
# bin/zookeeper-server-start.sh -daemon config/zookeeper.properties && sleep 5 && bin/kafka-server-start.sh -daemon config/server.properties && sleep 5 && bin/connect-standalone.sh -daemon config/connect-standalone.properties config/connect-file-source.properties
# sleep 3
# bin/kafka-server-start.sh -daemon config/server.properties
# sleep 300

# # Delete and recreate topic quickstart-events
# bin/kafka-topics.sh --delete --topic quickstart-events --bootstrap-server localhost:9092 || echo 'Failed to delete topic'
# bin/kafka-topics.sh --create --topic quickstart-events --bootstrap-server localhost:9092

# # Start Kafka Connect in standalone mode
# bin/connect-standalone.sh config/connect-standalone.properties -daemon config/connect-file-source.properties

# # Pass messages to the FileSourceConnector
# python3 write_tmp_test.py 100

# # Clean up
# pkill -9 -f java
# pkill -9 -f sleep
# sleep 1
# ps -A | grep java && _log '\nThe above java processes were not killed successfully' error

# # Inspect logs
# cat logs/connect.log | grep 'INFO FileStreamSourceTask buffer length is'