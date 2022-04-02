#!/bin/bash
set -e

[ -z "$1" ] && BUILDSCRIPT=build.sh || BUILDSCRIPT=$1

export PATH="$PREFIX/bin:$BUILD_PREFIX/Library/bin:$SRC_DIR:$PATH"
export CC=clang.exe
export CXX=clang++.exe
export RANLIB=llvm-ranlib
export AS=llvm-as
export AR=llvm-ar
export NM=llvm-nm
export LD=lld-link
export CFLAGS="-I${LIBRARY_INC} -O2 -D_CRT_SECURE_NO_WARNINGS -D_MT -D_DLL -nostdlib -Xclang --dependent-lib=msvcrt -fuse-ld=lld"
export CXXFLAGS="$CFLAGS"
export CPPFLAGS="$CFLAGS"
export LDFLAGS="-L${LIBRARY_LIB} -fuse-ld=lld -nostdlib -Xclang --dependent-lib=msvcrt"
export lt_cv_deplibs_check_method=pass_all

echo "You need to run patch_libtool bash function after configure to fix the libtool script."
echo "If your package uses OpenMP, add llvm-openmp to your host and run requirements."

patch_libtool () {
    # libtool has support for exporting symbols using either nm or dumpbin with some creative use of sed and awk,
    # but neither works correctly with C++ mangling schemes.
    # cmake's dll creation tool works, but need to hack libtool to get it working
    cwd=$(pwd)
    cd $PREFIX/bin
    sed -i.bak "s/export_symbols_cmds=/export_symbols_cmds2=/g" libtool
    sed "s/archive_expsym_cmds=/archive_expsym_cmds2=/g" libtool > libtool2
    echo "#!/bin/bash" > libtool
    echo "export_symbols_cmds=\"$SRC_DIR/create_def.sh \\\$export_symbols \\\$libobjs \\\$convenience \"" >> libtool
    echo "archive_expsym_cmds=\"\\\$CC -o \\\$tool_output_objdir\\\$soname \\\$libobjs \\\$compiler_flags \\\$deplibs -Wl,-DEF:\\\\\\\"\\\$export_symbols\\\\\\\" -Wl,-DLL,-IMPLIB:\\\\\\\"\\\$tool_output_objdir\\\$libname.dll.lib\\\\\\\"; echo \"" >> libtool
    cat libtool2 >> libtool
    sed -i.bak "s@|-fuse@|-fuse-ld=*|-nostdlib|-fuse@g" libtool
    cd $cwd
}

if [[ "${REMOVE_LIB_PREFIX}" != "no" ]]; then
    # Rename libpng.lib to png.lib
    LIB_RENAME_FILES=$(find ${PREFIX}/lib -maxdepth 1 -iname 'lib*.lib')
    for file in ${LIB_RENAME_FILES}; do
        libname=$(basename ${file})
        if [[ ! -f ${PREFIX}/lib/${libname:3} ]]; then
            cp ${PREFIX}/lib/${libname} ${PREFIX}/lib/${libname:3}
        fi
    done
fi

# run buildscript
source ./$BUILDSCRIPT

if [[  -f "${PREFIX}/lib/${PKG_NAME}.dll.lib" ]]; then
    if [[ -f "${PREFIX}/lib/${PKG_NAME}.lib" ]]; then
        mv "${PREFIX}/lib/${PKG_NAME}.lib" "${PREFIX}/lib/${PKG_NAME}_static.lib"
    fi
    mv "${PREFIX}/lib/${PKG_NAME}.dll.lib" "${PREFIX}/lib/${PKG_NAME}.lib"
fi


if [[ "${REMOVE_LIB_PREFIX}" != "no" ]]; then
    for file in ${LIB_RENAME_FILES}; do
        libname=$(basename ${file})
        rm ${PREFIX}/lib/${libname:3}
    done
fi
