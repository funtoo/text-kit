# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson virtualx

DESCRIPTION="UI library that focuses on simplicity and minimalism"
HOMEPAGE="https://pwmt.org/projects/girara/"
SRC_URI="https://pwmt.org/projects/girara/download/girara-0.4.0.tar.xz -> girara-0.4.0.tar.xz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="doc libnotify test"

RESTRICT="!test? ( test )"

DEPEND="dev-libs/glib:2
	dev-libs/json-glib:=
	>=x11-libs/gtk+-3.20:3
	libnotify? ( x11-libs/libnotify )"
RDEPEND="${DEPEND}"
BDEPEND="doc? ( app-doc/doxygen )
	test? ( dev-libs/check )
	virtual/pkgconfig"

src_configure() {
	local emesonargs=(
		-Djson=enabled
		-Ddocs=$(usex doc enabled disabled)
		-Dnotify=$(usex libnotify enabled disabled)
	)
	meson_src_configure
}

src_test() {
	virtx meson_src_test
}