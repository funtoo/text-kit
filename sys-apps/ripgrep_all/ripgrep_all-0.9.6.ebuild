# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="rga is a line-oriented search tool that allows you to look for a regex in a multitude of file types"
HOMEPAGE="https://github.com/phiresky/ripgrep-all"
SRC_URI="https://github.com/phiresky/ripgrep-all/tarball/291033bf9f125af778e9008b8d9b346825dcc327 -> ripgrep-all-0.9.6-291033b.tar.gz
https://direct.funtoo.org/94/fb/39/94fb39574671f2aec8f21544b914735bd58e9920416a93056d510dc154f7bda7d3b85a1c8e0a706d703e4c39840088d2685db933eff4a31769ad69b9a98e63f8 -> ripgrep_all-0.9.6-funtoo-crates-bundle-d24e2804c6e4d4cb62ddfdfe649b4155092acc57cab090119a341e5d897456562f21f82ce425d30fca43da4b4f561d92fb6267f9ffb91fc5c1ae351ad264276a.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
	virtual/rust
	|| (
		app-text/pandoc-bin
		app-text/pandoc
	)
	app-text/poppler
	media-video/ffmpeg
	sys-apps/ripgrep
"

src_unpack() {
	cargo_src_unpack

	rm -rf ${S}
	mv ${WORKDIR}/phiresky-ripgrep-all-* ${S} || die
}