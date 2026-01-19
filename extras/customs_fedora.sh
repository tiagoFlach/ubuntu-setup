#!/bin/bash

# Extensions
gsettings set org.gnome.shell enabled-extensions '[]'

# Media keys
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Primary><Alt>t']"
