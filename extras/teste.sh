#!/bin/bash

# sudo sed -i 's/<Directory \/var\/www\/>Options Indexes FollowSymLinks/<Directory \/var\/www\/>\n	Options Indexes FollowSymLinks\n	AllowOverride None\n	Require all granted\n<\/Directory>/g' /etc/apache2/apache2.conf
# sudo tr '<Directory \/var\/www\/>\n\tOptions Indexes FollowSymLinks' '<Directory \/var\/www\/>\n	Options Indexes FollowSymLinks\n	AllowOverride None\n	Require all granted\n<\/Directory>' < /etc/apache2/apache2.conf > /etc/apache2/apache2.conf
# sudo sed -i 's/<Directory \/var\/www\/>[^<\/Directory>]*>/Options Indexes FollowSymLinks\n	AllowOverride All\n	Require all granted\n/' /etc/apache2/apache2.conf

# Apache
# sudo sed -i ':a;N;$!ba;s/<Directory \/var\/www\/>\n	Options Indexes FollowSymLinks\n	AllowOverride None\n	Require all granted\n<\/Directory>/<Directory \/var\/www\/>\n	Options Indexes FollowSymLinks\n	AllowOverride All\n	Require all granted\n<\/Directory>/g' /etc/apache2/apache2.conf

# add vscode to path "desenvolvimento" in app menu

# Função para remover colchetes e aspas simples, e converter a string em uma array
string_to_array() {
    local input_string=$1
    input_string=${input_string#"["}
    input_string=${input_string%"]"}
    input_string=${input_string//\'/\"}
    input_string=${input_string//, / }
    eval "array=($input_string)"
}

# Função para converter uma array de volta para uma string no formato original
array_to_string() {
    local array=("$@")
    local output_string="["
    for item in "${array[@]}"; do
        output_string+="'$item', "
    done
    output_string=${output_string%, } # Remove a última vírgula e espaço
    output_string+="]"
    echo "$output_string"
}

addToFolder() {
    folder_name=$1
    app_name=$2

    # Listar pastas
    folders=$(gsettings get org.gnome.desktop.app-folders folder-children)

    string_to_array "$folders"

    echo $folders

    # Verificar se a pasta desejada existe
    if [[ $folders != *"$folder_name"* ]]; then
        folders+=$folder_name

        # Criar pasta
        # gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/$folder_name/ name "$folder_name"

        # gsettings set org.gnome.

        # Adicionar à pasta
        # gsettings set org.gnome.desktop.app-folders folder-children "['$app_name', 'Utilities']"
    fi

    echo $folders
    # gsettings set org.gnome.desktop.app-folders folder-children "['Pardus', 'Utilities', 'YaST']"
}

addToFolder "Desenvolvimento" "code"
