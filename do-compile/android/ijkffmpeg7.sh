#! /usr/bin/env bash
#
# Copyright (C) 2021 Matt Reach<qianlongxu@gmail.com>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This script is based on projects below
# https://github.com/bilibili/ijkplayer

set -e

error_handler() {
    echo "An error occurred!"
    tail -n20 ${MR_BUILD_SOURCE}/ffbuild/config.log
}

trap 'error_handler' ERR

THIS_DIR=$(DIRNAME=$(dirname "$0"); cd "$DIRNAME"; pwd)
cd "$THIS_DIR"

# ijkplayer 用的 FFmpeg 7：ijk 裁剪配置 + 只探测 OpenSSL（不链 dav1d/bluray/smb2 等三方库）
source $MR_SHELL_CONFIGS_DIR/ijk-ffmpeg-config/module-lite-ff7.sh

THIRD_CFG_FLAGS=
THIRD_CFG_FLAGS="$THIRD_CFG_FLAGS --prefix=$MR_BUILD_PREFIX"
THIRD_CFG_FLAGS="$THIRD_CFG_FLAGS --enable-static --disable-shared --enable-pic"
THIRD_CFG_FLAGS="$THIRD_CFG_FLAGS --pkg-config-flags=--static"
if [[ "$MR_DEBUG" == "debug" ]]; then
    THIRD_CFG_FLAGS="$THIRD_CFG_FLAGS --disable-optimizations --enable-debug --disable-small"
else
    THIRD_CFG_FLAGS="$THIRD_CFG_FLAGS --enable-optimizations --enable-debug --enable-small"
fi
THIRD_CFG_FLAGS="$THIRD_CFG_FLAGS --disable-stripping"
THIRD_CFG_FLAGS="$THIRD_CFG_FLAGS --arch=$MR_FF_ARCH --target-os=$MR_TAGET_OS"
THIRD_CFG_FLAGS="$THIRD_CFG_FLAGS --sysroot=$MR_SYS_ROOT --enable-cross-compile"
# 不启用 FFmpeg 自带的 MediaCodec 解码器（ijk 有自己的 MediaCodec 管线），也就不依赖 libmediandk / JNI
THIRD_CFG_FLAGS="$THIRD_CFG_FLAGS --disable-jni --disable-mediacodec"
THIRD_CFG_FLAGS="$THIRD_CFG_FLAGS --disable-iconv --disable-bzlib"
if [[ "$MR_ARCH" == "armv7a" || "$MR_ARCH" == "arm64" ]]; then
    # NEON 汇编（libijkplayer.so 链接时需 -Wl,-Bsymbolic）
    THIRD_CFG_FLAGS="$THIRD_CFG_FLAGS --enable-neon --enable-asm --enable-inline-asm"
else
    THIRD_CFG_FLAGS="$THIRD_CFG_FLAGS --disable-neon --disable-asm --disable-inline-asm"
fi

pkg-config --libs openssl --silence-errors >/dev/null && enable_openssl=1
if [[ $enable_openssl ]]; then
    echo "[✅] --enable-openssl : $(pkg-config --modversion openssl)"
    # 本配置为 LGPL（--disable-gpl），OpenSSL 无需 --enable-nonfree（仅 GPL 构建才要求）
    THIRD_CFG_FLAGS="$THIRD_CFG_FLAGS --enable-openssl"
else
    echo "[❌] --disable-openssl"
fi

CFG_FLAGS=
CFG_FLAGS="$CFG_FLAGS $COMMON_FF_CFG_FLAGS"
CFG_FLAGS="$CFG_FLAGS $THIRD_CFG_FLAGS"

# Android 15 with 16 kb page size support
# https://developer.android.com/guide/practices/page-sizes#compile-r27
EXTRA_LDFLAGS="-Wl,-z,max-page-size=16384"
C_FLAGS="$C_FLAGS $MR_DEFAULT_CFLAGS"
LDFLAGS="$C_FLAGS $EXTRA_LDFLAGS"


echo "----------------------"
echo "[*] configure"

if [[ ! -d $MR_BUILD_SOURCE ]]; then
    echo ""
    echo "!! ERROR"
    echo "!! Can not find lib source: $MR_BUILD_SOURCE"
    echo "!! Run 'init-*.sh' first"
    echo ""
    exit 1
fi

cd $MR_BUILD_SOURCE

if [[ -f "./config.h" ]]; then
    echo 'reuse configure'
else
    echo
    echo "CC: $MR_TRIPLE_CC"
    echo "CFLAGS: $C_FLAGS"
    echo "LDFLAG:$LDFLAGS"
    echo "FF_CFG_FLAGS: $CFG_FLAGS"
    echo

    ./configure \
        $CFG_FLAGS \
        --cc=${MR_TRIPLE_CC} \
        --as=${MR_TRIPLE_CC} \
        --ld=${MR_TRIPLE_CC} \
        --ar=${MR_AR} \
        --nm=${MR_NM} \
        --strip=${MR_STRIP} \
        --ranlib=${MR_RANLIB} \
        --extra-cflags="$C_FLAGS" \
        --extra-cxxflags="$C_FLAGS" \
        --extra-ldflags="$LDFLAGS" \
        --pkg-config=${MR_PKG_CONFIG_EXECUTABLE}
fi

#----------------------
echo "----------------------"
echo "[*] compile"

# V=1
make V=1 -j$MR_HOST_NPROC >/dev/null

echo "----------------------"
echo "[*] install"

cp config.* $MR_BUILD_PREFIX
make install >/dev/null
mkdir -p $MR_BUILD_PREFIX/include/libffmpeg
cp -f config.h $MR_BUILD_PREFIX/include/libffmpeg/
[ -e config_components.h ] && cp -f config_components.h $MR_BUILD_PREFIX/include/libffmpeg/
# copy private header for ffmpeg-kit.
[ -e $MR_BUILD_SOURCE/libavutil/getenv_utf8.h ] && cp -f $MR_BUILD_SOURCE/libavutil/getenv_utf8.h $MR_BUILD_PREFIX/include/libavutil/
cp -f $MR_BUILD_SOURCE/libavutil/internal.h $MR_BUILD_PREFIX/include/libavutil/
cp -f $MR_BUILD_SOURCE/libavutil/libm.h $MR_BUILD_PREFIX/include/libavutil/
[ -e $MR_BUILD_SOURCE/libavutil/attributes_internal.h ] && cp -f $MR_BUILD_SOURCE/libavutil/attributes_internal.h $MR_BUILD_PREFIX/include/libavutil/
cp -f $MR_BUILD_SOURCE/libavcodec/mathops.h $MR_BUILD_PREFIX/include/libavcodec/

mkdir -p $MR_BUILD_PREFIX/include/libavcodec/x86/
cp -f $MR_BUILD_SOURCE/libavcodec/x86/mathops.h $MR_BUILD_PREFIX/include/libavcodec/x86/
mkdir -p $MR_BUILD_PREFIX/include/libavutil/x86/
cp -f $MR_BUILD_SOURCE/libavutil/x86/asm.h $MR_BUILD_PREFIX/include/libavutil/x86/