# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Create a book from markdown files"
HOMEPAGE="https://rust-lang.github.io/mdBook/"
SRC_URI="https://github.com/rust-lang/mdBook/tarball/5a4ac03c0de866c4cf30d41dd0c7ea02d8429a7a -> mdBook-0.4.37-5a4ac03.tar.gz
https://direct.funtoo.org/a7/f7/b0/a7f7b09357056f14ae2d680fe0464b87a1f837a6515307dd27134e986d22f29d50fd78b15ae94f428f29357f6ab061ee4db77bb148b4050c9fa134dca093167d -> mdbook-0.4.37-funtoo-crates-bundle-12d1b28242fb9aadbc71369a15a0fbe11c219480b18ab7b36da27028e209a17ca304a558154c14fcdeda3e4e85f3b81ca2548cc43775ce500a8936778eaf621d.tar.gz"
S="${WORKDIR}/rust-lang-mdBook-5a4ac03"

# CC-BY-4.0/OFL-1.1: embeds fonts inside the executable
LICENSE="MPL-2.0 CC-BY-4.0 OFL-1.1"
LICENSE+="
	Apache-2.0 BSD ISC MIT Unicode-DFS-2016
	|| ( Artistic-2 CC0-1.0 )
" # crates
SLOT="0"
KEYWORDS="*"
IUSE="doc"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_compile() {
	cargo_src_compile

	if use doc; then
		if tc-is-cross-compiler; then
			ewarn "html docs were skipped due to cross-compilation"
		else
			target/$(usex debug{,} release)/${PN} build -d html guide || die
		fi
	fi
}

src_install() {
	cargo_src_install

	dodoc CHANGELOG.md README.md
	use doc && ! tc-is-cross-compiler && dodoc -r guide/html
}