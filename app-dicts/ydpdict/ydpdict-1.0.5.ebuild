# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="None"
HOMEPAGE="https://github.com/wojtekka/ydpdict"
SRC_URI="https://github.com/wojtekka/ydpdict/tarball/5a161ec8eb8b95adf94cac9df799f0d220d17ea8 -> ydpdict-1.0.5-5a161ec.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="ao"

RDEPEND="
	app-dicts/libydpdict
	sys-libs/ncurses:=
	ao? ( media-libs/libao )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=(
	README.md
)
PATCHES=(
	"${FILESDIR}"/${PN}-1.0.3-tinfo.patch
)

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv wojtekka-ydpdict* "${S}" || die
	fi
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_with ao libao)
}

src_install() {
	dodir "/etc"
	default
}

pkg_postinst() {
	echo
	elog "Note that to use this program you'll need the original Collins Dictionary"
	elog "datafiles (dict100.*, dict101.*). These can be found in the Dabasase/"
	elog "directory of the Windows version of the Collins dictionary. Once you obtain"
	elog "the files, put them into /usr/share/ydpdict"
	elog
	elog "Some configuration options can be set in /etc/ydpdict.conf"
	echo
}