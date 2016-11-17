#!/bin/bash

# This zip file corrects a Crystal Rom build, making it flashable in TWRP.

# Some fancy stuff
blink="\E[5m"
bold="\E[1m"
dim="\E[2m"
rev="\E[7m"
sitm="\E[3m"
ritm="\E[23m"
smso="\E[7m"
rmso="\E[27m"
smul="\E[4m"
rmul="\E[24m"
crystal_blue=$'\e[38;5;39m'
crystal_error=$'\e[38;5;196m'
reset="\e(B\e[m"

cd $HOME/crystal/$PRODUCT_OUT/$CRYSTAL_OUT
echo -en "${bold}${crystal_blue}[cd] Entered the standard output directory."

# unzip the target file
echo -en "${bold}${crystal_blue}${blink}[unzip] Unzipping output zip..."
unzip -d out_temp_files $CRYSTAL_OUT
echo -en ${reset}

# we enter the directory
echo -en "${bold}${crystal_blue}${blink}[cd] Entering temporary directory: ${PRODUCT_OUT}/out_temp_files/ ..."
cd out_temp_files/
echo -en ${reset}

# remove the old udate-binary causing error 6 in twrp
echo -en "${bold}${crystal_error}${blink}[rm -rf] Removing old update-binary causing error in twrp..."
rm -rf META-INF/com/google/android/update-binary
echo -en ${reset}

# copy the factory ota's update-binary
echo -en "${bold}${crystal_blue}${blink}[cp] Copying factory ota's update-binary..."
cp $HOME/crystal/vendor/crystal/update-binary META-INF/com/google/android/update-binary
echo -en ${reset}

# zip it again and tell the out to the user.
echo -en "${bold}${crystal_blue}${blink}[zip] Zipping back the output zip..."
date := $(shell date -u +%d%m%Y_%H.%M)
zip $(PRODUCT_OUT)/$(USER)-$(TARGET_PRODUCT)-$(CRYSTAL_VERSION)-$(CRYSTAL_VERSION_CODENAME)-$(CRYSTAL_VERSION_BRANCH)-$(date)-flashable.zip *
echo -en ${reset}
echo -en "${bold}${crystal_blue}[i] TARGET_OUTPUT_FLASHABLE: $HOME/crystal/$PRODUCT_OUT/$(PRODUCT_OUT)/$(USER)-$(TARGET_PRODUCT)-$(CRYSTAL_VERSION)-$(CRYSTAL_VERSION_CODENAME)-$(CRYSTAL_VERSION_BRANCH)-$(date)-flashable.zip"
