# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Tail on steroids"
HOMEPAGE="http://www.vanheusden.com/multitail/ https://github.com/folkertvanheusden/multitail/"
SRC_URI="https://github.com/folkertvanheusden/multitail/tarball/f24eb8d7706a87504acbeb860906528a4f58dd31 -> multitail-7.1.3-f24eb8d.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="debug examples unicode"

RDEPEND="sys-libs/ncurses:="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${PN}-7.0.0-gentoo.patch
)

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv folkertvanheusden-multitail* "${S}" || die
	fi
}

src_prepare() {
	cmake_src_prepare
	# cmake looks for licence.txt to install it, which does not exist in the package
	cp LICENSE license.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DUTF8_SUPPORT=$(usex unicode)
	)
	CMAKE_BUILD_TYPE=$(usex debug Debug)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	insinto /etc
	doins multitail.conf

	rm -rf "${ED}"/usr/{ect,etc} || die
	rm -rf "${ED}"/usr/share/doc/multitail-VERSION=6.4.3 || die

	DOCS=( readme.txt thanks.txt )
	HTML_DOCS=( manual.html )
	einstalldocs

	if use examples; then
		docinto examples
		dodoc conversion-scripts/colors-example.{pl,sh} conversion-scripts/convert-{geoip,simple}.pl
	fi
}

pkg_postinst() {
	einfo "install x11-misc/xclip send a buffer to the X clipboard"
}