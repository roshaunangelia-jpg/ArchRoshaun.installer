if [ -f "do-not-delete.txt" ]; then
    echo "Setup complete..."
    echo "starting desktop environment..."
    sleep 3

    startx
    bash /opt/archros/src/desktop.sh
else
    echo "Installing whiptail..."
    sudo pacman -S --noconfirm whiptail

    export NEWT_COLORS='
    root=green,black
    border=green,black
    window=black,black
    title=green,black
    textbox=green,black
    entry=green,black
    button=black,green
    actbutton=black,green
    checkbox=green,black
    actcheckbox=black,green
    listbox=green,black
    actlistbox=black,green
    '

    whiptail --title "ArchRoshaun First-Time Setup" --ok-button "Proceed" \
    --msgbox "ArchRoshaun First-Time Setup. This will guide you through the setup process, press 'Proceed' to continue." 30 80

    user=$(
      whiptail --title "ArchRoshaun First-Time Setup" \
      --inputbox "Enter your username:" 20 80 3>&1 1>&2 2>&3
    )
    if [ -z "$user" ]; then
        echo "No username entered. Aborting setup."
        exit 1
    fi

    pass=$(
      whiptail --title "ArchRoshaun First-Time Setup" \
      --inputbox "Enter your password (optional):" 20 80 3>&1 1>&2 2>&3
    )

    if id "$user" &>/dev/null; then
        echo "User $user already exists, skipping adduser."
    else
        sudo useradd -m "$user"
        echo "User $user created successfully"
    fi

    if [ -n "$pass" ]; then
        echo "Setting password for $user"
        echo "$user:$pass" | sudo chpasswd
        echo "Password set successfully"
    else
        echo "No password provided, skipping password setting"
    fi

    mkdir -p settings

    choices=$(
      whiptail --title "Select Options" \
      --checklist "Choose features:" 30 80 8 \
          "1" "Install programming applications (Geany, Thonny, etc.)" ON \
          "2" "Install online applications (Chromium, Firefox)" ON \
          "3" "Install built-in/utility applications (PCmanFm, raindrop, etc.)" ON \
          "4" "Install system applications (htop, neofetch, etc.)" ON \
          "5" "Install custom applications (ArchRoshaun, etc.)" ON \
          "6" "Enable auto-update system" OFF \
          "7" "Enable ArchRecovery (backup and restore system)" ON \
          3>&1 1>&2 2>&3
    )

    echo "Selected: $choices"

    # Remove quotes and line breaks, get just the numbers  
    for choice in $choices; do
        choice=$(echo "$choice" | tr -d '"')
        case $choice in
            1)
                (
                  sudo pacman -S --noconfirm thonny geany
                ) | whiptail --gauge "Installing programming applications" 10 50 0
                ;;
            2)
                (
                  sudo pacman -S --noconfirm chromium firefox
                ) | whiptail --gauge "Installing online applications" 10 50 0
                ;;
            3)
                (
                  sudo pacman -S --noconfirm pcmanfm
                  # The following packages may not exist in the Arch repos; comment out or handle as needed
                  if pacman -Si raindrop &>/dev/null; then
                      sudo pacman -S --noconfirm raindrop
                      wait 2
                  fi
                  if pacman -Si pi-apps &>/dev/null; then
                      sudo pacman -S --noconfirm pi-apps
                      wait 2
                  fi
                  if pacman -Si apt &>/dev/null; then
                      sudo pacman -S --noconfirm apt
                      wait 2
                  fi
                ) | whiptail --gauge "Installing built-in/utility applications" 10 50 0
                ;;
            4)
                (
                  sudo pacman -S --noconfirm htop neofetch
                  wait 2
                ) | whiptail --gauge "Installing system applications" 10 50 0
                ;;
            5)
                echo "Custom application install placeholder" # Add actual commands as needed
                ;;
            6)
                touch settings/enable-auto-update
                ;;
            7)
                touch settings/archrecovery-on
                ;;
        esac
    done

    touch do-not-delete.txt

    clear
    echo "--------------------------------"

    echo "Restarting in 10s..."
    echo "Thank you for using ArchRoshaun!"
    wait 10
    reboot
fi

echo "The session ended with code $?"
bash