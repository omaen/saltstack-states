#!/bin/bash
#
# This script is only used for new installs. Roundcube uses the
# interactive script in bin/installto.sh to do upgrades, so
# that obviously fails for this purpose.
#

url="{{ salt['pillar.get']('roundcube:download_url') }}"
tmpfile=$(mktemp)
tmpdir=$(mktemp -d)
user="www-data"
group="www-data"
defaults_file="/root/.my.cnf"
install_dir="/srv/roundcube"
db="{{ salt['pillar.get']('roundcube:db') }}"
db_user="{{ salt['pillar.get']('roundcube:db_user') }}"
db_password="{{ salt['pillar.get']('roundcube:db_password') }}"


error_handler () {
    script_name="$0"
    line="$1"
    exit_code="$2"
    echo "${script_name}: Error in line $line (exit code ${exit_code})"
    cleanup
    exit $exit_code
}

cleanup () {
    rm -f "$tmpfile"
    [[ -d $tmpdir ]] && rm -r "$tmpdir"
}

trap 'error_handler ${LINENO} $?' ERR

# Download and unpack the files. Ensure permissions are okay.
wget --no-verbose -O "$tmpfile" "$url"
tar -C "$tmpdir" -xzf "$tmpfile"
[[ -d $install_dir ]] && exit 1
mv "${tmpdir}/roundcubemail-"* "$install_dir"
chown root:root -R "${install_dir}"
chown ${user}:${group} -R "${install_dir}/temp"
chown ${user}:${group} -R "${install_dir}/logs"
rm -rf "${install_dir}/installer"

# Configure the database
mysql --defaults-file="$defaults_file" -u root << EOF
CREATE DATABASE IF NOT EXISTS ${db};
GRANT ALL PRIVILEGES ON ${db}.* TO '$db_user'@'localhost' IDENTIFIED BY '$db_password';
FLUSH PRIVILEGES;
EOF

# Set up the initial database schema. Will fail if it already exists
mysql --defaults-file="$defaults_file" -u root $db < "${install_dir}/SQL/mysql.initial.sql"

cleanup
trap - ERR
