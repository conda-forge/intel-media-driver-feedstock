set -ex

mkdir build
pushd build

# LIBVA_DRIVERS_PATH must be specified so that things are found correctly
# in our splayed environments in conda forge
# However, the environment variable conflicts with the name
# of the install path
# Upstream compiles the driver objects with -Werror. GCC 15 emits a false
# positive on the static APIMap in media_ddi_encode_hevc.cpp:55, which that
# turns into a hard failure:
#   bits/stl_pair.h:312:17: error: array subscript 0 is outside array bounds
#   of 'void [0]' [-Werror=array-bounds=]
#   cc1plus: note: source object is likely at address zero
# https://github.com/intel/media-driver/issues/1950
cmake ${CMAKE_ARGS} \
   -DLIBVA_DRIVERS_PATH=${PREFIX}/lib/dri \
   -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
   -DMEDIA_BUILD_FATAL_WARNINGS=OFF \
   ..

make -j${CPU_COUNT}

make install
