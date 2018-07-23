#! /bin/sh
#
# find the file in /usr/lib
LIBEGL=`find /usr/lib/nvidia* -name libEGL.so.\* | egrep "[0-9][0-9]*\.[0-9][0-9]*$"`
LIBEGL_LINK=`echo $LIBEGL | sed 's/[0-9][0-9]*\.[0-9][0-9]*$/1/'`
printf "\n\nThe following commands will be executed:\n+++++++++++++++++++++++++++++++++++++++\n"
printf "mv $LIBEGL_LINK ${LIBEGL_LINK}.orig\nln -s $LIBEGL $LIBEGL_LINK\n\n"
while true; do
    read -p "Do you wish to perform these commands?  " yn
    case $yn in
        [Yy]* ) mv $LIBEGL_LINK ${LIBEGL_LINK}.orig; ln -s $LIBEGL $LIBEGL_LINK ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# find the file in /usr/lib32
LIBEGL=`find /usr/lib32/nvidia* -name libEGL.so.\* | egrep "[0-9][0-9]*\.[0-9][0-9]*$"`
LIBEGL_LINK=`echo $LIBEGL | sed 's/[0-9][0-9]*\.[0-9][0-9]*$/1/'`
printf "\n\nThe following commands will be executed:\n+++++++++++++++++++++++++++++++++++++++\n"
printf "mv $LIBEGL_LINK ${LIBEGL_LINK}.orig\nln -s $LIBEGL $LIBEGL_LINK\n\n"
while true; do
    read -p "Do you wish to perform these commands?  " yn
    case $yn in
        [Yy]* ) mv $LIBEGL_LINK ${LIBEGL_LINK}.orig; ln -s $LIBEGL $LIBEGL_LINK ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
