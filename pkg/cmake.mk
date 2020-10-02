pkg_ver  := 3.18.3
pkg_repo := https://github.com/Kitware/CMake
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)
pkg_deps := libressl

pkg_configure := cmake -G Ninja $(pkg_srcdir) \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/usr \
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
	-DBUILD_QtDialog:BOOL=OFF

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
