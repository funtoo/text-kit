# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Markdown translator producing HTML5, roff documents in the ms and man formats"
HOMEPAGE="https://kristaps.bsd.lv/lowdown/"
SRC_URI="https://github.com/kristapsdz/lowdown/tarball/67d206caffde1de6667319d5ecda1d00eb758827 -> lowdown-1.1.0-67d206c.tar.gz"
S="${WORKDIR}/kristapsdz-lowdown-67d206c"

LICENSE="ISC"
SLOT="0/1"
KEYWORDS="*"

DEPEND="
	sys-libs/libxcrypt
	app-crypt/libmd
"
RDEPEND="
	${DEPEND}
"

# configure tests for a bunch of BSD functions on Linux
QA_CONFIG_IMPL_DECL_SKIP=(
	crypt_newhash
	crypt_checkpass
	warnc
	errc
	getexecname
	getprogname
	memset_s
	pledge
	recallocarray
	strlcat
	strlcpy
	strtonum
	TAILQ_FOREACH_SAFE
	unveil
)

PATCHES=(
	"${FILESDIR}/${PN}-linking.patch"
)

src_prepare() {
	default

	sed -i '/^Libs:/ s/$/ -lmd/' lowdown.in.pc
}

src_configure() {
	append-flags -fPIC
	tc-export CC AR

	./configure \
		PREFIX="/usr" \
		MANDIR="/usr/share/man" \
		LDFLAGS="${LDFLAGS}" \
		CPPFLAGS="${CPPFLAGS}" \
		LIBDIR="/usr/$(get_libdir)" \
		|| die "./configure failed"
}