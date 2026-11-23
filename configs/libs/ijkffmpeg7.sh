#! /usr/bin/env bash
#
# ijkplayer 用的 FFmpeg 7：官方 FFmpeg + patches/ffmpeg-n7.1.1（restore-ijk-* 等补丁），
# 按 ijk-ffmpeg-config/module-lite-ff7.sh 裁剪，只依赖 OpenSSL（与 ijkffmpeg 4.0 相同的 1.1.1w）。
# 与 fsplayer 用的 ffmpeg7（module-full + 大量三方库）分开，产物目录为 ijkffmpeg7-<arch>。

export LIB_NAME='ijkffmpeg7'
export LIPO_LIBS="libavcodec libavformat libavutil libswscale libswresample libavfilter"
export LIB_DEPENDS_BIN="nasm pkg-config"
export GIT_LOCAL_REPO=extra/ffmpeg
export REPO_DIR=ijkffmpeg7
export PATCH_DIR=ffmpeg-n7.1.1

if [[ "$GIT_FFMPEG_UPSTREAM" != "" ]] ;then
    export GIT_UPSTREAM="$GIT_FFMPEG_UPSTREAM"
else
    export GIT_UPSTREAM=https://github.com/FFmpeg/FFmpeg.git
fi

if [[ "$GIT_IJKFFMPEG7_COMMIT" != "" ]] ;then
    export GIT_COMMIT="$GIT_IJKFFMPEG7_COMMIT"
    export GIT_REPO_VERSION="$GIT_IJKFFMPEG7_COMMIT"
else
    export GIT_COMMIT=n7.1.3
    export GIT_REPO_VERSION=7.1.3
fi
