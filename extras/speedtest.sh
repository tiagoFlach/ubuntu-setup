#!/bin/bash
# wget -qO - https://packagecloud.io/ookla/speedtest-cli/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/sublimetext-keyring.gpg
# curl -fsSL https://packagecloud.io/ookla/speedtest-cli/gpgkey | sudo gpg --dearmor -o /etc/apt/keyrings

os="Ubuntu"
dist="focal"

gpg_key_url="https://packagecloud.io/ookla/speedtest-cli/gpgkey"
apt_config_url="https://packagecloud.io/install/repositories/ookla/speedtest-cli/config_file.list?os=${os}&dist=${dist}&source=script"

apt_source_path="/etc/apt/sources.list.d/ookla_speedtest-cli.list"
apt_keyrings_dir="/etc/apt/keyrings"

if [ ! -d "$apt_keyrings_dir" ]; then
    mkdir -p "$apt_keyrings_dir"
fi

gpg_keyring_path="$apt_keyrings_dir/ookla_speedtest-cli-archive-keyring.gpg"
gpg_key_path_old="/etc/apt/trusted.gpg.d/ookla_speedtest-cli.gpg"

echo -n "Installing $apt_source_path..."

# create an apt config file for this repository
curl -sSf "${apt_config_url}" >$apt_source_path
curl_exit_code=$?

if [ "$curl_exit_code" = "22" ]; then
    echo
    echo
    echo -n "Unable to download repo config from: "
    echo "${apt_config_url}"
    echo
    echo "This usually happens if your operating system is not supported by "
    echo "packagecloud.io, or this script's OS detection failed."
    echo
    echo "You can override the OS detection by setting os= and dist= prior to running this script."
    echo "You can find a list of supported OSes and distributions on our website: https://packagecloud.io/docs#os_distro_version"
    echo
    echo "For example, to force Ubuntu Trusty: os=ubuntu dist=trusty ./script.sh"
    echo
    echo "If you are running a supported OS, please email support@packagecloud.io and report this."
    [ -e $apt_source_path ] && rm $apt_source_path
    exit 1
elif [ "$curl_exit_code" = "35" -o "$curl_exit_code" = "60" ]; then
    echo "curl is unable to connect to packagecloud.io over TLS when running: "
    echo "    curl ${apt_config_url}"
    echo "This is usually due to one of two things:"
    echo
    echo " 1.) Missing CA root certificates (make sure the ca-certificates package is installed)"
    echo " 2.) An old version of libssl. Try upgrading libssl on your system to a more recent version"
    echo
    echo "Contact support@packagecloud.io with information about your system for help."
    [ -e $apt_source_path ] && rm $apt_source_path
    exit 1
elif [ "$curl_exit_code" -gt "0" ]; then
    echo
    echo "Unable to run: "
    echo "    curl ${apt_config_url}"
    echo
    echo "Double check your curl installation and try again."
    [ -e $apt_source_path ] && rm $apt_source_path
    exit 1
else
    echo "done."
fi

echo -n "Importing packagecloud gpg key... "
# import the gpg key
curl -fsSL "${gpg_key_url}" | gpg --dearmor >${gpg_keyring_path}

# grant 644 permisions to gpg keyring path
chmod 0644 "${gpg_keyring_path}"

# move gpg key to old path if apt version is older than 1.1
if [ "${apt_version_modified}" -lt 110 ]; then
    # move to trusted.gpg.d

    mv ${gpg_keyring_path} ${gpg_key_path_old}
    # grant 644 permisions to gpg key path
    chmod 0644 "${gpg_key_path_old}"

    # deletes the keyrings directory if it is empty
    if ! ls -1qA $apt_keyrings_dir | grep -q .; then
        rm -r $apt_keyrings_dir
    fi
    echo "Packagecloud gpg key imported to ${gpg_key_path_old}"
else
    echo "Packagecloud gpg key imported to ${gpg_keyring_path}"
fi
echo "done."

echo -n "Running apt-get update... "

# update apt on this system
apt-get update &>/dev/null
echo "done."

echo
echo "The repository is setup! You can now install packages."

sudo apt install speedtest -y
