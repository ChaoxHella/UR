#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/siat/catkin_UR5/src/universal_robot/ur_kinematics"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/siat/catkin_UR5/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/siat/catkin_UR5/install/lib/python2.7/dist-packages:/home/siat/catkin_UR5/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/siat/catkin_UR5/build" \
    "/usr/bin/python2" \
    "/home/siat/catkin_UR5/src/universal_robot/ur_kinematics/setup.py" \
     \
    build --build-base "/home/siat/catkin_UR5/build/universal_robot/ur_kinematics" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/siat/catkin_UR5/install" --install-scripts="/home/siat/catkin_UR5/install/bin"
