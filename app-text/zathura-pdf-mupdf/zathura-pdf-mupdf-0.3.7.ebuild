# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson xdg


DESCRIPTION="PDF plug-in for zathura"
HOMEPAGE="https://pwmt.org/projects/zathura-pdf-mupdf/"
SRC_URI="https://pwmt.org/projects/zathura-pdf-mupdf/download/zathura-pdf-mupdf-0.3.7.tar.xz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=">=app-text/mupdf-1.17:=
	>=app-text/zathura-0.3.9
	dev-libs/girara
	dev-libs/glib:2
	media-libs/jbig2dec:=
	media-libs/openjpeg:2=
	virtual/jpeg:0
	x11-libs/cairo"

RDEPEND="${DEPEND}"

BDEPEND="virtual/pkgconfig"

src_prepare() {
	sed -i -e '/mupdfthird/d' meson.build || die "sed failed"

	default
}