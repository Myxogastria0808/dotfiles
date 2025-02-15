#!/bin/bash

cd $HOME/Desktop

#setup waydroid and GAPPS
sudo waydroid init -s GAPPS -f

#install F-Droid
wget https://f-droid.org/F-Droid.apk
waydroid app install ./F-Droid.apk
rm F-Droid.apk

#display Google Play Certification
#参考サイト: https://docs.waydro.id/faq/google-play-certification
echo 1. run follow command with waydroid shell
echo ANDROID_RUNTIME_ROOT=/apex/com.android.runtime ANDROID_DATA=/data ANDROID_TZDATA_ROOT=/apex/com.android.tzdata ANDROID_I18N_ROOT=/apex/com.android.i18n sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "select * from main where name = \"android_id\";"
echo 2. access and register number with follow URL
echo https://www.google.com/android/uncertified/
sudo waydroid shell

#install libhoudini
#参考サイト: https://sumadoratyper.net/notes/7f721210cfdb91577e29e1aba980bb4a2baccecf/
git clone https://github.com/casualsnek/waydroid_script
cd waydroid_script
python3 -m venv venv
venv/bin/pip install -r requirements.txt
sudo venv/bin/python3 main.py install libhoudini
cd ..
sudo rm -rf waydroid_script
