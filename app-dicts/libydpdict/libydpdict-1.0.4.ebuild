# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="None"
HOMEPAGE="https://github.com/wojtekka/libydpdict"
SRC_URI="https://github.com/wojtekka/libydpdict/tarball/ab69f41b8238251b45a54e795f58a18ae584acd7 -> libydpdict-1.0.4-ab69f41.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"

DOCS=( AUTHORS )

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv wojtekka-libydpdict* "${S}" || die
	fi
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --disable-static
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}