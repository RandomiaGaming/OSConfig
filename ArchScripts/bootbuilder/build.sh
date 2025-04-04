\echo -e ""

# Build initramfs
echo -e "Building initramfs with mkinitcpio to \"/bootbuilder/initramfs-linux\"..."
rm -f /bootbuilder/initramfs-linux
mkinitcpio -c /bootbuilder/mkinitcpio.conf -k /bootbuilder/vmlinuz-linux -g /bootbuilder/initramfs-linux || exit
chmod 600 /bootbuilder/initramfs-linux
echo -e "Successfully built initramfs."
echo -e ""

# Make UKI
echo -e "Making unified kernel image with ukify to \"/bootbuilder/uki.efi\"..."
rm -f /bootbuilder/uki.efi
ukify -c /bootbuilder/ukify.conf build -o /bootbuilder/uki.efi || exit
chmod 600 /bootbuilder/uki.efi
echo -e "Successfully made unified kernel image."
echo -e ""

# Setup EFI Partition
echo -e "Setting up EFI partition..."
rm -rf /boot/*
mkdir /boot/EFI
chmod 700 /boot/EFI
mkdir /boot/EFI/UKI
chmod 700 /boot/EFI/UKI
cp /bootbuilder/uki.efi /boot/EFI/UKI/UKI.EFI
chmod 600 /boot/EFI/UKI/UKI.EFI
echo -e "Successfully set up EFI partition."
echo -e ""

# Setup EFI boot manager
echo -e "Setting up EFI boot manager..."
efibootmgr | grep -o "^Boot[0-9]\{4\}" | sed "s/Boot//" | while read bootnum; do
    efibootmgr -b $bootnum -B > /dev/null
done
bootdev=$(findmnt -n -o SOURCE --target /boot)
bootpart="${bootdev##*[!0-9]}"
bootdisk="${bootdev%$bootpart}"
[[ "${bootdisk: -1}" == "p" ]] && bootdisk="${bootdisk::-1}"
efibootmgr -c -d $bootdisk -p $bootpart -l /EFI/UKI/UKI.EFI -L "Arch Linux UKI" > /dev/null
efibootmgr -o 0000 > /dev/null
efibootmgr -t 0 > /dev/null
echo -e "Successfully set up EFI boot manager."
echo -e ""
