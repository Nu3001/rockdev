#!/bin/bash
pause()
{
echo "Press any key to quit:"
read -n1 -s key
exit 1
}
echo "Starting to make backup.img..."
if [ ! -f "parameter" ]; then
	echo "Error:No parameter file found!"
	pause
fi
if [ ! -f "package-file" ]; then
	echo "Error:No package-file found!"
	pause
fi
./afptool -pack ./backupimage ./backupimage/backup.img || pause
echo "Build: backup.img OK"
echo "Starting to make update.img..."
./afptool -pack ./ output/update_noboot.img || pause
./rkImageMaker -RK31 RK3188Loader\(L\)_V2.15.bin output/update_noboot.img update.img -os_type:androidos || pause
echo "Build: update.img OK."
echo "Removing temp files."
rm ./backupimage/backup.img || pause
rm ./output/update_noboot.img || pause
echo "Temp files removed."
#echo "Press any key to quit:"
#read -n1 -s key
#exit 0
