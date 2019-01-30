# Given a csv file and a path argument, creates a manifest file,
# or adds to an existing manifest file.
#
# Assumes that datafiles follow standard naming convention:
#    {entity_name}_{version}_{timestamp}.csv
#
# usage: $0 -p data_path data_file [manifest_file]

while getopts ":p:" opt; do
  case $opt in
    p)
      echo "Using pathname: $OPTARG" >&2
			pathname=$OPTARG
			shift; shift;
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
			echo "  Valid paths are like: "
			echo "      s3://gooddata-demo/acme/ (S3)"
			echo "  or  /sftp4acme  (SFTP)"
      exit 1
      ;;
  esac
done

# set the data file location
if [ ! -f ${1} ]; then
	echo "No data file found called ${1}"
	exit 1
else
	newfile=$1
fi

# set the manifest file location
if [ $# -eq 1 ]; then
	timestamp=`date "+%s"`
	manifest="manifest_${timestamp}.csv"
elif [ $# -eq 2 ]; then
	if [ ! -f ${2} ]; then
		echo "No manifest file found called ${2}"
		exit 1
	else
		manifest=$2
	fi
fi

if [ -z ${pathname} ] || [ -z $manifest ] || [ -z $newfile ]; then
	echo "usage: $0 -p data_path data_file [manifest_file]"
	exit 1
fi

if [ ! -f ${manifest} ]; then
	echo "Creating manifest file..."
	echo "file_url|timestamp|feed|feed_version|num_rows|md5|export_type" > $manifest
fi

# Compute the checksum and number of rows
cksum=`md5 -q $newfile`
num_rows=`tail +2 $newfile | wc -l`
echo "Data file ${newfile} has ${num_rows} rows"

# extract the parts of the file name
# assumes default naming scheme: entity_version_timestamp.csv
basename=`basename ${newfile}`
t1="${basename##*_}"
timestamp="${t1%.*}"
entity="${basename%%_*}"

# Add datafile to manifest
echo "${pathname}/${basename}|${timestamp}|${entity}|1|${num_rows}|${cksum}|" >> $manifest
