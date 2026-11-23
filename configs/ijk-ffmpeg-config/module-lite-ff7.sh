#! /usr/bin/env bash
#
# FFmpeg 7 版 ijk 裁剪配置：由 module-lite.sh（FFmpeg 4.0 / ijkffmpeg）移植。
# 差异：
#   - 去掉 FFmpeg 5 已删除的选项（--disable-avresample 等）
#   - 显式打开 ijk 自定义 demuxer（ijklivehook / ijklas）：FFmpeg 7 的 demuxer 列表在编译期固定，
#     ijkmedia 运行时只把实现挂到补丁预留的占位上，--disable-demuxers 后不打开就找不到
#   - mp4 muxer 额外启用 mov muxer，并保留其依赖 vp9_superframe bsf
#! /usr/bin/env bash

#--------------------
# Standard options:
export COMMON_FF_CFG_FLAGS=
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --prefix=PREFIX"

# Licensing options:
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-gpl"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-version3"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-nonfree"

# Configuration options:
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-static"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-shared"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-small"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-runtime-cpudetect"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-gray"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-swscale-alpha"

# Program options:
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-programs"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-ffmpeg"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-ffplay"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-ffprobe"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-ffserver"

# Documentation options:
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-doc"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-htmlpages"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-manpages"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-podpages"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-txtpages"

# Component options:
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-avdevice"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-avcodec"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-avformat"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-avutil"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-swresample"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-swscale"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-postproc"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-avfilter"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-pthreads"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-w32threads"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-os2threads"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-network"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-dct"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-dwt"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-lsp"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-lzo"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mdct"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-rdft"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-fft"

# Hardware accelerators:
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-d3d11va"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-dxva2"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-vaapi"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-vda"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-vdpau"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-videotoolbox"

# Individual component options:
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-everything"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-encoders"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-encoder=png"

# ./configure --list-decoders
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-decoders"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=aac"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=aac_latm"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=flv"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=h264"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=mp3*"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=vp6f"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=flac"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=hevc"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=vp8"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=vp9"
#117
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=pcm_s16le --enable-decoder=pcm_s16be --enable-decoder=pcm_u16le --enable-decoder=pcm_u16be --enable-decoder=pcm_alaw --enable-decoder=pcm_mulaw"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-hwaccels"

# ./configure --list-muxers
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-muxers"
# 录制/转存 mp4 需要（安防监控 App 将视频流转存为 mp4）；FFmpeg 7 中 mp4 muxer 依赖 mov muxer
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-muxer=mp4"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-muxer=mov"

# ./configure --list-demuxers
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-demuxers"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=aac"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=concat"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=data"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=flv"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=hls"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=live_flv"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=ijklivehook"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=ijklas"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=mov"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=mp3"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=mpegps"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=mpegts"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=mpegvideo"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=flac"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=hevc"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=webm_dash_manifest"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-demuxer=rtsp"

# ./configure --list-parsers
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-parsers"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-parser=aac"
# fix ld: error: undefined symbol: ff_ac3_parse_header
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-parser=ac3"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-parser=aac_latm"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-parser=h264"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-parser=flac"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-parser=hevc"

# ./configure --list-bsf
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-bsfs"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsf=chomp"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsf=dca_core"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsf=dump_extradata"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsf=hevc_mp4toannexb"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsf=imx_dump_header"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsf=mjpeg2jpeg"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsf=mjpega_dump_header"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsf=mov2textsub"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsf=mp3_header_decompress"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsf=mpeg4_unpack_bframes"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsf=noise"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsf=remove_extradata"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bsf=text2movsub"
# vp9_superframe 为 mov muxer 的依赖，FFmpeg 7 中不能再禁用

# ./configure --list-protocols
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-protocols"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-protocol=async"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=bluray"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=concat"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-protocol=crypto"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=ffrtmpcrypt"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-protocol=ffrtmphttp"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=gopher"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=icecast"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=librtmp*"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=libssh"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=md5"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=mmsh"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=mmst"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=rtmp*"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-protocol=rtmp"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-protocol=rtmpt"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-protocol=rtmps"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-protocol=rtp"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=sctp"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-protocol=srtp"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=subfile"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-protocol=unix"

#
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-devices"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-filters"

# External library support:
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-iconv"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-audiotoolbox"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-videotoolbox"

# ...

# Advanced options (experts only):
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --cross-prefix=${FF_CROSS_PREFIX}-"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-cross-compile"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --sysroot=PATH"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --sysinclude=PATH"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --target-os=TAGET_OS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --target-exec=CMD"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --target-path=DIR"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --toolchain=NAME"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --nm=NM"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --ar=AR"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --as=AS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --yasmexe=EXE"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --cc=CC"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --cxx=CXX"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --dep-cc=DEPCC"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --ld=LD"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-cc=HOSTCC"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-cflags=HCFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-cppflags=HCPPFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-ld=HOSTLD"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-ldflags=HLDFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-libs=HLIBS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --host-os=OS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --extra-cflags=ECFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --extra-cxxflags=ECFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --extra-ldflags=ELDFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --extra-libs=ELIBS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --extra-version=STRING"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --optflags=OPTFLAGS"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --build-suffix=SUFFIX"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --malloc-prefix=PREFIX"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --progs-suffix=SUFFIX"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --arch=ARCH"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --cpu=CPU"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-pic"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-sram"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-thumb"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-symver"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-hardcoded-tables"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-safe-bitstream-reader"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-memalign-hack"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-lto"

# Optimization options (experts only):
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-asm"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-altivec"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-amd3dnow"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-amd3dnowext"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mmx"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mmxext"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-sse"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-sse2"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-sse3"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-ssse3"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-sse4"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-sse42"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-avx"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-fma4"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-armv5te"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-armv6"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-armv6t2"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-vfp"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-neon"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-vis"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-inline-asm"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-yasm"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mips32r2"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mipsdspr1"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mipsdspr2"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-mipsfpu"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-fast-unaligned"

# Developer options (useful when working on FFmpeg itself):
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-coverage"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-debug"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-debug=LEVEL"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-optimizations"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-extra-warnings"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-stripping"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --assert-level=level"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-memory-poisoning"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --valgrind=VALGRIND"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-ftrapv"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --samples=PATH"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-xmm-clobber-test"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-random"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-random"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-random=LIST"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-random=LIST"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --random-seed=VALUE"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-linux-perf"
export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --disable-bzlib"

