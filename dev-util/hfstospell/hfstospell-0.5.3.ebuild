# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools toolchain-funcs

DESCRIPTION="HFST spell checker library and command line tool"
HOMEPAGE="https://github.com/hfst/hfst-ospell"
SRC_URI="https://github.com/hfst/hfst-ospell/releases/download/v0.5.3/hfst-ospell-0.5.3.tar.bz2 -> hfst-ospell-0.5.3.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="clang"

DEPEND="app-arch/libarchive:=
	dev-libs/icu:=
	!clang? (
		dev-cpp/glibmm:2
		dev-cpp/libxmlpp:2.6
		dev-libs/glib:2
		dev-libs/libsigc++:2
		dev-libs/libxml2
	)"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/hfst-ospell-${PV}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	# https://github.com/hfst/hfst-ospell/issues/48
	if tc-is-clang; then
		econf --without-libxmlpp --without-tinyxml2
	elif use clang; then
		econf --without-libxmlpp --without-tinyxml2
	else
		default
	fi
}

src_install() {
	default
	find "${D}" -name '*.la' -delete -o -name '*.a' -delete || die
}
