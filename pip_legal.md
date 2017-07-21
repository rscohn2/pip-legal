# Distributing proprietary binaries with Pip / PyPi

Pip (see below) is a command line utility that downloads and installs software
distribtions (packages) (see below) from the Python Package Index (PyPI)
website (see below) - a public archive of Python packages.

There are currently no license restrictions on the packages that a user can
upload to the PyPI.  It is therefore possible for the user to
ask Pip to install software using a copy-left license along with software
using an incompatible (for example, proprietary) license.

This document is to ask for advice as to when such an install represents a
violation of the GPL license terms.

Our immediate motivation is that we want to compile the Numpy Python package
using the Intel Fortran compiler, which would result in Numpy packages that
contain proprietary closed source binaries belonging to the Intel Fortran
run-time library.  We are worried that this will make it more likely that Pip
/ PyPI will cause a violation of the GPL.

## Some terms

### Package

A Python Package is an archive of files that can be installed on a user's
computer.  The Python interpreter can use (*import*) files from the Package.

### Pip

Pip is the standard command line program for installing Python packages onto a
user's computer.  Downloads of Python from Python.org will automatically
install Pip when installing Python.  Pip is the installation tool
[recommended](https://packaging.python.org/tutorials/installing-packages/#requirements-for-installing-packages)
by the [Python Packaging Authority](https://www.pypa.io) (see below).

### Python Packaging Authority - PyPA

The [Python Packaging Authority](https://www.pypa.io) is the official Python
body advising on the installation of Python packages.

### Python Package Index - PyPI

PyPi is the [Python Package Index](https://pypi.python.org/pypi).  See also
[the PyPi Wikipedia
article](https://en.wikipedia.org/wiki/Python_Package_Index).  PyPi is a
software repository, consisting of an archive of packages, and a web service
through which Pip, in particular, can search for and download packages.

## Pip installs software from PyPI

The standard use of Pip is to install packages from the command line.

The user passes a specification of what packages they want to Pip. Call this
specification "the original specification".  Pip downloads packages matching
the original specification and, for each package P in the original
specification, Pip determines the specification of packages that P depends on
-- call this P-spec. For each package in P-spec, Pip checks whether the user
already has a package matching P-spec, and if not, it runs another download /
specification check on P-spec, continuing recursively until it has packages
matching the original specification and all missing dependent packages.

For example, here is a terminal session where the user asks Pip for the
[Scipy](https://pypi.python.org/pypi/scipy) package.  The Scipy package
depends on the [Numpy](https://pypi.python.org/pypi/numpy) package.  Pip
downloads both Scipy and Numpy, and installs them:

    $ pip install scipy
    Collecting scipy
    Downloading scipy-0.19.1-cp35-cp35m-macosx_10_6_intel.macosx_10_9_intel.macosx_10_9_x86_64.macosx_10_10_intel.macosx_10_10_x86_64.whl (16.1MB)
        100% |████████████████████████████████| 16.1MB 14.3MB/s 
    Collecting numpy>=1.8.2 (from scipy)
    Downloading numpy-1.13.1-cp35-cp35m-macosx_10_6_intel.macosx_10_9_intel.macosx_10_9_x86_64.macosx_10_10_intel.macosx_10_10_x86_64.whl (4.5MB)
        100% |████████████████████████████████| 4.5MB 6.1MB/s 
    Installing collected packages: numpy, scipy
    Successfully installed numpy-1.13.1 scipy-0.19.1

## Questions

Imagine a Python package, hosted on PyPI, licensed under the GPL, called
`gpl_package`.

Imagine another Python package, hosted on PyPI, with a proprietary license,
called `proprietary_package`.

Imagine that the user has a Python script they have written themselves, which
uses both packages.  The script might look like this:

    # users_script.py
    import gpl_package
    import proprietary_package

    data = get_some_data()
    processed_data_1 = gpl_package.do_a_gpl_thing(data)
    processed_data_2 = proprietary_package.do_a_non_gpl_thing(processd_data_1)

They then run their script:

    python users_script.py


* should the set of packages installed in a particular call to Pip be
  considered a software "distribution" in the GPL sense?
* should the union of all sets of packages installed by multiple calls to Pip
  also be considered a software "distribution" in the GPL sense?

## Examples

Imagine a GPL package `gpl_package` available on PyPI.

The package `gpl_package` contains the following Python code, which will run
whenever the user does (in Python) `>>> import gpl_package`:

    import numpy

That is, any use of `gpl_package` will also use the `numpy` package.

Imagine that the Numpy package contains proprietary compiled code.  

