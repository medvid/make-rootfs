pkg_ver  := 3.19.2
pkg_repo := https://github.com/Kitware/CMake
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)
pkg_deps := openssl

pkg_configure := $(cmake_pkg_configure) \
	-DCMAKE_DATA_DIR=share/cmake \
	-DCMAKE_DOC_DIR=share/doc/cmake \
	-DCMAKE_C_COMPILER=clang \
	-DCMAKE_CXX_COMPILER=clang++ \
	-DCMAKE_EXE_LINKER_FLAGS="-static" \
	-DCMAKE_LINKER=lld \
	-DCMAKE_USE_OPENSSL:BOOL=ON \
	-DCMAKE_USE_SYSTEM_LIBRARIES:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DBUILD_CursesDialog:BOOL=OFF \
	-DBUILD_QtDialog:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
