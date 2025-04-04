echo -e "Removing orphaned packages"
if [ ! -z "$(yay -Qqdt)" ]; then
    echo -e "$(yay -Qqdt)"
    yay -Rns $(yay -Qqdt)
else
    echo -e "there is nothing to do"
fi

echo -e "Updating all packages"
yay -Syu
echo -e ""
