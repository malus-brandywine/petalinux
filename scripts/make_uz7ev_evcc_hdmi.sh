# ----------------------------------------------------------------------------
#
#        ** **        **          **  ****      **  **********  ********** ®
#       **   **        **        **   ** **     **  **              **
#      **     **        **      **    **  **    **  **              **
#     **       **        **    **     **   **   **  *********       **
#    **         **        **  **      **    **  **  **              **
#   **           **        ****       **     ** **  **              **
#  **  .........  **        **        **      ****  **********      **
#     ...........
#                                     Reach Further™
#
# ----------------------------------------------------------------------------
#
#  This design is the property of Avnet.  Publication of this
#  design is not authorized without written consent from Avnet.
#
#  Please direct any questions to the UltraZed community support forum:
#     http://www.ultrazed.org/forum
#
#  Product information is available at:
#     http://zedboard.org/product/ultrazed
#
#  Disclaimer:
#     Avnet, Inc. makes no warranty for the use of this code or design.
#     This code is provided  "As Is". Avnet, Inc assumes no responsibility for
#     any errors, which may appear in this code, nor does it make a commitment
#     to update the information contained herein. Avnet, Inc specifically
#     disclaims any implied warranties of fitness for a particular purpose.
#                      Copyright(c) 2017 Avnet, Inc.
#                              All rights reserved.
#
# ----------------------------------------------------------------------------
#
#  Create Date:         Jan. 20, 2021
#  Design Name:         Avnet UZ7EV_EVCC_HDMI PetaLinux BSP Generator
#  Module Name:         make_uz7ev_evcc_hdmi.sh
#  Project Name:        Avnet UZ7EV_EVCC_HDMI PetaLinux BSP Generator
#  Target Devices:      Xilinx Zynq Ultrascale MPSoC
#  Hardware Boards:     UZ7EV_EVCC Board
#
#  Tool versions:       Xilinx Vivado 2020.2
#
#  Description:         Build Script for UZ7EV_EVCC with HDMI support PetaLinux BSP HW Platform
#
#  Dependencies:        Common Script 'common.sh'
#
#  Revision:            Jan. 20, 2021: 1.00 Initial version
#
# ----------------------------------------------------------------------------

#!/bin/bash

# Stop the script whenever we had an error (non-zero returning function)
set -e

# MAIN_SCRIPT_FOLDER is the folder where this current script is
MAIN_SCRIPT_FOLDER=$(realpath $0 | xargs dirname)

FSBL_PROJECT_NAME=zynqmp_fsbl

HDL_PROJECT_NAME=hdmi
HDL_BOARD_NAME=uz7ev_evcc

ARCH="aarch64"
SOC="zynqMP"

PETALINUX_BOARD_FAMILY=uz
PETALINUX_BOARD_NAME=uz7ev_evcc_hdmi
PETALINUX_PROJECT_BASE_NAME=${PETALINUX_BOARD_NAME}
PETALINUX_BUILD_IMAGE=avnet-image-full

KEEP_CACHE="true"
KEEP_WORK="false"
DEBUG="no"

#NO_BIT_OPTION can be set to 'yes' to generate a BOOT.BIN without bitstream
NO_BIT_OPTION='yes'

source ${MAIN_SCRIPT_FOLDER}/common.sh

verify_repositories
verify_environment
check_git_tag

build_hw_platform
create_petalinux_project
configure_petalinux_project

BOOT_METHOD='EXT4'
configure_boot_method
build_bsp

package_bsp
