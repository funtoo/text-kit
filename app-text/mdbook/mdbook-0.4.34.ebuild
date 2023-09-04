# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Create a book from markdown files"
HOMEPAGE="https://rust-lang.github.io/mdBook/"
SRC_URI="https://github.com/rust-lang/mdBook/tarball/56c225bd34760eb6de024b67b42729e4a55b6302 -> mdBook-0.4.34-56c225b.tar.gz
https://direct.funtoo.org/d5/e2/24/d5e2241f68ce5eaeb9376cdc0ac92d5b81634f2c2c4026b546a7d6a3d5e47a77b713e439bdb33541e6f8c3d2722714a2cc9dcf14028eb886040173ec976f4472 -> mdbook-0.4.34-funtoo-crates-bundle-fd2d2f7ee3b734781d1a225b9a9902fc239239b407b02dd4ebf74f294133bb965980e1c0d5172e93c4b5423622564dec6ca99e9484470d2929e87e0a0d6d3563.tar.gz"
S="${WORKDIR}/rust-lang-mdBook-56c225b"

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