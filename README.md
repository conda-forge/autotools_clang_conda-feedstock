About autotools_clang_conda-feedstock
=====================================

Feedstock license: [BSD-3-Clause](https://github.com/conda-forge/autotools_clang_conda-feedstock/blob/main/LICENSE.txt)


About autotools_clang_conda
---------------------------

Home: http://github.com/conda-forge/autotools_clang_conda-feedstock

Package license: BSD-3-Clause

Summary: Scripts to compile autotools projects on windows using clang and llvm tools

This package installs Clang, LLD, LLVM tools, Bash, and Autoconf to build
Autotools projects on Windows. Resulting packages are MSVC-compatible.
To use this package in a Windows recipe, skip non-Windows targets, add the
target C compiler through the recipe's `compiler('c')` helper, and add
`autotools_clang_conda` to the build requirements. Add `llvm-openmp` only
when OpenMP is required. On Windows ARM64, the wrapper supplies canonical
Autotools build and host aliases for the native compiler target.

    build:
      skip: not win
    requirements:
      build:
        - vs2022_win-64
        - autotools_clang_conda

In bld.bat

    call %BUILD_PREFIX%\Library\bin\run_autotools_clang_conda_build.bat
    if %ERRORLEVEL% neq 0 exit 1

In build.sh

    ./configure --prefix=$PREFIX
    [[ "$target_platform" == win-* ]] && patch_libtool
    make -j${CPU_COUNT}
    make install

In case the build script has a different name (for example in multi-output recipes),
you can pass the name of the build script in the recipe folder to the bat-script:

In build_subpackage.bat

    call %BUILD_PREFIX%\Library\bin\run_autotools_clang_conda_build.bat build_subpackage.sh
    if %ERRORLEVEL% neq 0 exit 1

About autotools_clang_conda
---------------------------

Home: http://github.com/conda-forge/autotools_clang_conda-feedstock

Package license: BSD-3-Clause

Summary: Scripts to compile autotools projects on windows using clang and llvm tools

This package installs Clang, LLD, LLVM tools, Bash, and Autoconf to build
Autotools projects on Windows. Resulting packages are MSVC-compatible.
To use this package in a Windows recipe, skip non-Windows targets, add the
target C compiler through the recipe's `compiler('c')` helper, and add
`autotools_clang_conda` to the build requirements. Add `llvm-openmp` only
when OpenMP is required. On Windows ARM64, the wrapper supplies canonical
Autotools build and host aliases for the native compiler target.

    build:
      skip: not win
    requirements:
      build:
        - vs2022_win-arm64
        - autotools_clang_conda

In bld.bat

    call %BUILD_PREFIX%\Library\bin\run_autotools_clang_conda_build.bat
    if %ERRORLEVEL% neq 0 exit 1

In build.sh

    ./configure --prefix=$PREFIX
    [[ "$target_platform" == win-* ]] && patch_libtool
    make -j${CPU_COUNT}
    make install

In case the build script has a different name (for example in multi-output recipes),
you can pass the name of the build script in the recipe folder to the bat-script:

In build_subpackage.bat

    call %BUILD_PREFIX%\Library\bin\run_autotools_clang_conda_build.bat build_subpackage.sh
    if %ERRORLEVEL% neq 0 exit 1

Current build status
====================


<table><tr>
    <td>GitHub Actions</td>
    <td>
      <a href="https://github.com/conda-forge/autotools_clang_conda-feedstock/actions/workflows/conda-build.yml">
        <img src="https://github.com/conda-forge/autotools_clang_conda-feedstock/actions/workflows/conda-build.yml/badge.svg?event=push&branch=main">
      </a>
    </td>
  </tr>
    
  <tr>
    <td>Azure</td>
    <td>
      <details>
        <summary>
          <a href="https://dev.azure.com/conda-forge/feedstock-builds/_build/latest?definitionId=7523&branchName=main">
            <img src="https://dev.azure.com/conda-forge/feedstock-builds/_apis/build/status/autotools_clang_conda-feedstock?branchName=main">
          </a>
        </summary>
        <table>
          <thead><tr><th>Variant</th><th>Status</th></tr></thead>
          <tbody>
          </tbody>
        </table>
      </details>
    </td>
  </tr>
</table>

Current release info
====================

| Name | Downloads | Version | Platforms |
| --- | --- | --- | --- |
| [![Conda Recipe](https://img.shields.io/badge/recipe-autotools__clang__conda-green.svg)](https://anaconda.org/conda-forge/autotools_clang_conda) | [![Conda Downloads](https://img.shields.io/conda/dn/conda-forge/autotools_clang_conda.svg)](https://anaconda.org/conda-forge/autotools_clang_conda) | [![Conda Version](https://img.shields.io/conda/vn/conda-forge/autotools_clang_conda.svg)](https://anaconda.org/conda-forge/autotools_clang_conda) | [![Conda Platforms](https://img.shields.io/conda/pn/conda-forge/autotools_clang_conda.svg)](https://anaconda.org/conda-forge/autotools_clang_conda) |

Installing autotools_clang_conda
================================

Installing `autotools_clang_conda` from the `conda-forge` channel can be achieved by adding `conda-forge` to your channels with:

```
conda config --add channels conda-forge
conda config --set channel_priority strict
```

How to use
----------

<details>
<summary>With conda</summary>

```
conda install autotools_clang_conda
```

</details>

<details>
<summary>With mamba</summary>

```
mamba install autotools_clang_conda
```

</details>

<details>
<summary>With pixi</summary>

```
# for adding to your local project
pixi add autotools_clang_conda
# for installing globally
pixi global install autotools_clang_conda
```

</details>

Search package versions
-----------------------

It is possible to list all of the versions of `autotools_clang_conda` available on your platform:

<details>
<summary>With conda</summary>

```
conda search autotools_clang_conda --channel conda-forge
```

</details>

<details>
<summary>With mamba</summary>

```
mamba search autotools_clang_conda --channel conda-forge
```

</details>

<details>
<summary>With pixi</summary>

```
pixi search autotools_clang_conda --channel conda-forge
```

</details>

<details>
<summary>With mamba repoquery, which may provide more information</summary>

```
# Search all versions available on your platform:
mamba repoquery search autotools_clang_conda --channel conda-forge

# List packages depending on `autotools_clang_conda`:
mamba repoquery whoneeds autotools_clang_conda --channel conda-forge

# List dependencies of `autotools_clang_conda`:
mamba repoquery depends autotools_clang_conda --channel conda-forge
```

</details>


About conda-forge
=================

[![Powered by
NumFOCUS](https://img.shields.io/badge/powered%20by-NumFOCUS-orange.svg?style=flat&colorA=E1523D&colorB=007D8A)](https://numfocus.org)

conda-forge is a community-led conda channel of installable packages.
In order to provide high-quality builds, the process has been automated into the
conda-forge GitHub organization. The conda-forge organization contains one repository
for each of the installable packages. Such a repository is known as a *feedstock*.

A feedstock is made up of a conda recipe (the instructions on what and how to build
the package) and the necessary configurations for automatic building using freely
available continuous integration services. Thanks to the awesome service provided by
[Azure](https://azure.microsoft.com/en-us/services/devops/), [GitHub](https://github.com/),
[CircleCI](https://circleci.com/), [AppVeyor](https://www.appveyor.com/),
[Drone](https://cloud.drone.io/welcome), and [TravisCI](https://travis-ci.com/)
it is possible to build and upload installable packages to the
[conda-forge](https://anaconda.org/conda-forge) [anaconda.org](https://anaconda.org/)
channel for Linux, Windows and OSX respectively.

To manage the continuous integration and simplify feedstock maintenance,
[conda-smithy](https://github.com/conda-forge/conda-smithy) has been developed.
Using the ``conda-forge.yml`` within this repository, it is possible to re-render all of
this feedstock's supporting files (e.g. the CI configuration files) with ``conda smithy rerender``.

For more information, please check the [conda-forge documentation](https://conda-forge.org/docs/).

Terminology
===========

**feedstock** - the conda recipe (raw material), supporting scripts and CI configuration.

**conda-smithy** - the tool which helps orchestrate the feedstock.
                   Its primary use is in the construction of the CI ``.yml`` files
                   and simplify the management of *many* feedstocks.

**conda-forge** - the place where the feedstock and smithy live and work to
                  produce the finished article (built conda distributions)


Updating autotools_clang_conda-feedstock
========================================

If you would like to improve the autotools_clang_conda recipe or build a new
package version, please fork this repository and submit a PR. Upon submission,
your changes will be run on the appropriate platforms to give the reviewer an
opportunity to confirm that the changes result in a successful build. Once
merged, the recipe will be re-built and uploaded automatically to the
`conda-forge` channel, whereupon the built conda packages will be available for
everybody to install and use from the `conda-forge` channel.
Note that all branches in the conda-forge/autotools_clang_conda-feedstock are
immediately built and any created packages are uploaded, so PRs should be based
on branches in forks, and branches in the main repository should only be used to
build distinct package versions.

In order to produce a uniquely identifiable distribution:
 * If the version of a package **is not** being increased, please add or increase
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string).
 * If the version of a package **is** being increased, please remember to return
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string)
   back to 0.

Feedstock Maintainers
=====================

* [@isuruf](https://github.com/isuruf/)

