#!/bin/bash

backupPath=$(dirname "$(dirname "$(readlink -f "$0")")")/personal/backup

# sudo cp -f $backupPath/tiago /var/lib/AccountsService/icons/
# sudo sed -i 's/\(Icon=\).*/\1\/var\/lib\/AccountsService\/icons\/$USER/' /var/lib/AccountsService/users/$USER

$image_path = $backupPath/tiago

# Comando dbus-send para atualizar a imagem do perfil
dbus_command="dbus-send --session --dest=org.gnome.Shell --print-reply \
        --reply-timeout=2000 --type=method_call \
        --dest=org.gnome.Shell \
        /org/gnome/Shell org.gnome.Shell.Eval \
        'const Gio = imports.gi.Gio; \
        const AccountsService = imports.gi.AccountsService; \
        let user = AccountsService.UserManager.get_default().get_user(GLib.get_user_name()); \
        let iconFile = Gio.File.new_for_path(\"$image_path\"); \
        user.set_icon_file(iconFile); \
        user.set_string(\"icon-name\", \"\");'"

# Executa o comando dbus-send
eval "$dbus_command"
