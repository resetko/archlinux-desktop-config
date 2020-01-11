#!/bin/sh

rofi \
   -show run \
   -matching fuzzy \
   -font "Terminus Medium 10" \
   -width 40 \
   -hide-scrollbar \
   -bw 0 \
   -lines 5 \
   -color-window "#ffffff, #f5f5f5" \
   -color-normal "#ffffff, #525d76, #f5f5f5, #5294e2, #ffffff" \
   -color-active "#ffffff, #c2cad0, #f5f5f5, #5294e2, #c2cad0" \
   -color-urgent "#ffffff, #dc322f, #f5f5f5, #5294e2, #dc322f"
