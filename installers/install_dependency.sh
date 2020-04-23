#!/usr/bin/env bash
set -e

cd /home/installers

#--------------------------------------------------------------------
# gflags
#--------------------------------------------------------------------
# TODO base
wget -nc -O gflags-2.2.2.tar.gz https://github.com/gflags/gflags/archive/v2.2.2.tar.gz || true
tar xzf gflags-2.2.2.tar.gz
mkdir gflags-2.2.2/build
pushd gflags-2.2.2/build
CXXFLAGS="-fPIC" cmake ..
make -j8
make install
popd

rm -fr gflags-2.2.2.tar.gz gflags-2.2.2

#--------------------------------------------------------------------
# glog
#--------------------------------------------------------------------
# TODO base
wget -nc -O glog-0.3.5.tar.gz https://github.com/google/glog/archive/v0.3.5.tar.gz || true
tar xzf glog-0.3.5.tar.gz
pushd glog-0.3.5
./configure
make -j8 CXXFLAGS='-Wno-sign-compare -Wno-unused-local-typedefs -D_START_GOOGLE_NAMESPACE_="namespace google {" -D_END_GOOGLE_NAMESPACE_="}" -DGOOGLE_NAMESPACE="google" -DHAVE_PTHREAD -DHAVE_SYS_UTSNAME_H -DHAVE_SYS_SYSCALL_H -DHAVE_SYS_TIME_H -DHAVE_STDINT_H -DHAVE_STRING_H -DHAVE_PREAD -DHAVE_FCNTL -DHAVE_SYS_TYPES_H -DHAVE_SYSLOG_H -DHAVE_LIB_GFLAGS -DHAVE_UNISTD_H'
make install
popd

rm -fr glog-0.3.5.tar.gz glog-0.3.5
rm -fr /usr/local/lib/libglog.so*

#--------------------------------------------------------------------
# qp-oases
#--------------------------------------------------------------------
tar xf qpOASES-3.2.1-inceptio.tar.xz
pushd qpOASES-3.2.1
make -j8 CPPFLAGS="-Wall -pedantic -Wshadow -Wfloat-equal -O3 -Wconversion \
                   -Wsign-conversion -fPIC -DLINUX -DSOLVER_NONE \
                   -D__NO_COPYRIGHT__"
mkdir -p /usr/local/include/qpOASES
cp bin/libqpOASES.a /usr/local/include/qpOASES
cp -r include/* /usr/local/include/qpOASES
popd

rm -fr qpOASES-3.2.1-inceptio.tar.xz qpOASES-3.2.1

# osqp
tar xf OSQP-0.5.0-inceptio.tar.xz
pushd osqp
mkdir build
pushd build

cmake -G "Unix Makefiles" ..
cmake --build .
cmake --build . --target install
cp out/libosqp.a /usr/local/include/osqp
popd
popd

rm -fr OSQP-0.5.0-inceptio.tar.xz osqp

#--------------------------------------------------------------------
# kvaser can
#--------------------------------------------------------------------
tar xzf linuxcan.tar.gz
pushd linuxcan
make canlib
cp canlib/libcanlib.so /usr/local/lib/
mkdir -p /usr/local/include/canlib
cp include/canlib.h /usr/local/include/canlib
cp include/canstat.h /usr/local/include/canlib
cp include/obsolete.h /usr/local/include/canlib
popd

rm -fr linuxcan.tar.gz linuxcan

#--------------------------------------------------------------------
# opencv -- only build the packages we need
#--------------------------------------------------------------------
wget -nc -O opencv-4.0.1.tar.gz https://github.com/opencv/opencv/archive/4.0.1.tar.gz || true
tar xzf opencv-4.0.1.tar.gz
pushd opencv-4.0.1
mkdir build
pushd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
  	-D CMAKE_INSTALL_PREFIX=/usr/local \
    -D BUILD_opencv_dnn=OFF \
    -D BUILD_opencv_java_bindings_generator=OFF \
    -D BUILD_opencv_js=OFF \
    -D BUILD_opencv_photo=OFF \
    -D BUILD_opencv_python_bindings_generator=OFF\
    -D BUILD_opencv_stitching=OFF \
    -D BUILD_opencv_ts=OFF \
    -D BUILD_JAVA=OFF \
    -D BUILD_PERF_TESTS=OFF\
    -D BUILD_opencv_apps=OFF \
    ..
make -j8
make install
ldconfig
popd
popd

rm -fr opencv-4.0.1.tar.gz opencv-4.0.1

#--------------------------------------------------------------------
# libgsl
#--------------------------------------------------------------------
wget -nc http://gnu.mirror.constant.com/gsl/gsl-2.5.tar.gz || true
tar -zxf gsl-2.5.tar.gz
pushd gsl-2.5
./configure
make -j`nproc`
make install
ldconfig
popd

rm -fr gsl-2.5.tar.gz gsl-2.5

# radar related
dpkg -i ./pdk-common_0.1-8523637_amd64.deb
dpkg -i ./pdk_0.1-8523637_amd64.deb
ln -s /usr/lib/x86_64-linux-gnu/libboost_system.so.1.65.1 /usr/lib/x86_64-linux-gnu/libboost_system.so.1.58.0

#--------------------------------------------------------------------
# Camera drivers, Spinnaker API from FLIR
#--------------------------------------------------------------------
# TODO : Using password in plain text is probably unwise. We need to change to a
# token based authentication.
apt-get update
apt-get install -y libusb-1.0-0
wget -nc http://artifact.rd.inceptioglobal.ai/artifactory/ttp-local/amd64/spinnaker/spinnaker-1.24.0.60.gz --user camerabot --password beepbeep123123 || true
tar -xvzf spinnaker-1.24.0.60.gz
pushd spinnaker-1.24.0.60-amd64
dpkg -i libspinnaker-*.deb
dpkg -i libspinvideo-*.deb
dpkg -i spinview-qt-*.deb
dpkg -i spinupdate-*.deb
dpkg -i spinnaker-*.deb
popd

rm -rf spinnaker-1.24.0.60-amd64

#--------------------------------------------------------------------
# tensorRT
#--------------------------------------------------------------------
wget -nc https://media.githubusercontent.com/media/abx67/gitdrive/master/nv-tensorrt-repo-ubuntu1804-cuda10.0-trt5.1.2.2-rc-20190227_1-1_amd64.deb || true
dpkg -i nv-tensorrt-repo-ubuntu1804-cuda10.0-trt5.1.2.2-rc-20190227_1-1_amd64.deb
apt-get update
apt-get install -y libnvinfer5=5.1.2-1+cuda10.0 libnvinfer-dev=5.1.2-1+cuda10.0
apt-mark hold libnvinfer5 libnvinfer-dev
apt-get clean

# lastools(laslib)
wget -nc -O LAStools-190812.tar.gz https://github.com/LAStools/LAStools/archive/e33141c05fbd04409cb5b5952fd091b9ca60d304.tar.gz || true
tar -zxf LAStools-190812.tar.gz
pushd LAStools-e33141c05fbd04409cb5b5952fd091b9ca60d304
make
mkdir -p /usr/local/include/LASlib
cp LASlib/lib/liblas.a /usr/local/include/LASlib
cp -r LASlib/inc/* /usr/local/include/LASlib
cp -r LASzip/src/* /usr/local/include/LASlib
popd
rm -rf LAStools-e33141c05fbd04409cb5b5952fd091b9ca60d304
