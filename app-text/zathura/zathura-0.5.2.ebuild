# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson virtualx xdg

DESCRIPTION="A highly customizable and functional document viewer"
HOMEPAGE="https://pwmt.org/projects/zathura/"
SRC_URI="https://pwmt.org/projects/zathura/download/zathura-0.5.2.tar.xz -> zathura-0.5.2.tar.xz
https://cdn.turret.cyou/354c6d33bfd3bbc67c0047af1328498978eef352/zathura-0.5.2-manpages.tar.xz -> zathura-0.5.2-manpages.tar.xz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="seccomp sqlite synctex test"

RESTRICT="!test? ( test )"

DEPEND=">=dev-libs/girara-0.3.7
	>=dev-libs/glib-2.50:2
	>=sys-devel/gettext-0.19.8
	x11-libs/cairo
	>=x11-libs/gtk+-3.22:3
	sys-apps/file
	seccomp? ( sys-libs/libseccomp )
	sqlite? ( >=dev-db/sqlite-3.5.9:3 )
	synctex? ( app-text/texlive-core )"

RDEPEND="${DEPEND}"

BDEPEND="
	test? ( dev-libs/appstream-glib
		dev-libs/check )
	virtual/pkgconfig"
PATCHES=(
	"${FILESDIR}"/"${PN}-0.5.2-disable-seccomp-tests.patch"
)

src_configure() {
	local emesonargs=(
		-Dconvert-icon=disabled
		-Dmanpages=disabled
		-Dseccomp=$(usex seccomp enabled disabled)
		-Dsqlite=$(usex sqlite enabled disabled)
		-Dsynctex=$(usex synctex enabled disabled)
		)
	meson_src_configure
}

src_install() {
	meson_src_install
	doman "${WORKDIR}"/man/zathura*
}

src_test() {
	virtx meson_src_test
}