#!/bin/bash


BUILD_BINUTILS_VERSION="2.37";
BUILD_BINUTILS_DIRNAME="binutils-$BUILD_BINUTILS_VERSION";
BUILD_BINUTILS_FILENAME="$BUILD_BINUTILS_DIRNAME.tar.xz";
BUILD_BINUTILS_URL="https://ftp.gnu.org/gnu/binutils/$BUILD_BINUTILS_FILENAME";

BUILD_GCC_VERSION="11.2.0";
BUILD_GCC_DIRNAME="gcc-$BUILD_GCC_VERSION";
BUILD_GCC_FILENAME="$BUILD_GCC_DIRNAME.tar.xz"
BUILD_GCC_URL="https://ftp.gnu.org/gnu/gcc/gcc-$BUILD_GCC_VERSION/$BUILD_GCC_FILENAME";

export PREFIX="$HOME/opt/cross"
export TARGET="i686-elf";
export PATH="$PREFIX/bin:$PATH"


if [ ! -d "/tmp/builder" ]; then
    mkdir /tmp/builder;
fi;

cd /tmp/builder;

wget -c $BUILD_BINUTILS_URL;
wget -c $BUILD_GCC_URL;

if [ ! -d $BUILD_BINUTILS_DIRNAME ]; then
    tar xvf $BUILD_BINUTILS_FILENAME;
fi;

if [ ! -d $BUILD_GCC_DIRNAME ]; then
    tar xvf $BUILD_GCC_FILENAME;
fi;

cd $BUILD_GCC_DIRNAME;
    contrib/download_prerequisites;
cd -;

if [ -d build ]; then
    rm -rfv build;
fi;

mkdir build;
cd build;
    ../$BUILD_BINUTILS_DIRNAME/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror &&
    make -j3 &&
    make -j3 install;
cd -;
rm -rf build;

mkdir build;
cd build;
    ../$BUILD_GCC_DIRNAME/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers &&
    make -j3 all-gcc &&
    make -j3 all-target-libgcc &&
    make -j3 install-gcc &&
    make -j3 install-target-libgcc 
cd -;
rm -rf build;

cd -;