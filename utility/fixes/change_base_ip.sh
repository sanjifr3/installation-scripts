#!/bin/bash
# Change ip addresses in drrobot_clinicrobot GUI

gedit ~/.config/Qt-Ros\ Package/drrobot_clinicrobot.conf

echo "Settings: "
echo " drrobot1:" 
echo "   robot_url1 = 192.168.0.65"
echo "   robot_url2 = 192.168.0.66"

echo " drrobot2:"
echo "   robot_url1 = 192.168.0.60"
echo "   robot_url2 = 192.168.0.61"
