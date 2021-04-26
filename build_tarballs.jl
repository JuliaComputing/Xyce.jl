# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder, Pkg

julia_version = "1.6.0"

name = "XyceWrapper"
version = v"0.1.0"

# Collection of sources required to complete build
sources = [
    DirectorySource("./src/xycelib"),
]

# Bash recipe for building across all platforms
script = raw"""
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX=${prefix} \
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TARGET_TOOLCHAIN} \
    -DCMAKE_FIND_ROOT_PATH=${prefix} \
    -DJulia_PREFIX=${prefix} \
    -DCMAKE_BUILD_TYPE=Release \
    ..
cmake --build . --config Release --target install -- -j${nproc}
"""

platforms = supported_platforms()

# The products that we will ensure are always built
products = [
    LibraryProduct("libxycelib", :xycelib),
]

# Dependencies that must be installed before this package can be built
dependencies = [
    Dependency("Xyce_jll"),
    Dependency("libcxxwrap_julia_jll"),
    BuildDependency(PackageSpec(name="libjulia_jll", version=julia_version)),
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies; preferred_gcc_version=v"10")
