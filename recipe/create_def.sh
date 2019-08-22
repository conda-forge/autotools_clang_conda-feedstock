#!/bin/bash

def_file="$1"
shift

tmp_dir=$(mktemp -d)
rm_dirs=()
rm_dirs+=("$tmp_dir")
touch $tmp_dir/symbol_list.txt

for arg in "$@"
do
    if [[ "$arg" == *.lib ]]; then
        extract_dir=$(mktemp -d)
        rm_dirs+=("$extract_dir")
        cp $arg $extract_dir/static_lib.lib
        pushd $extract_dir > /dev/null
        # Can't use ar x, because a file name may be duplicated
        # Use ar t to get a file list and this extract by filename
        # and send that file to the back, so that files with the same name
        # are extracted
        file_list="$($AR t static_lib.lib)"
        for file in $file_list; do
            ${AR} x $extract_dir/static_lib.lib $file
            sha256=$(sha256sum $file | cut -d " " -f 1)
            mv $file ${sha256}_${file}
            ${AR} m static_lib.lib $file
            cygpath -w "$extract_dir/${sha256}_${file}" >> $tmp_dir/symbol_list.txt
        done
        popd > /dev/null
    else
        cygpath -w "$arg" >> $tmp_dir/symbol_list.txt
    fi
done

cmake -E __create_def $def_file $tmp_dir/symbol_list.txt

for dir in "${rm_dirs[@]}"
do
   rm -rf "$dir"
done
