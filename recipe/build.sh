set -ex

mkdir build
pushd build

# LIBVA_DRIVERS_PATH must be specified so that things are found correctly
# in our splayed environments in conda forge
# However, the environment variable conflicts with the name
# of the install path
cmake ${CMAKE_ARGS} \
   -DLIBVA_DRIVERS_PATH=${PREFIX}/lib/dri \
   ..

make -j${CPU_COUNT}

make install
