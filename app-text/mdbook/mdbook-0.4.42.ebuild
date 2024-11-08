# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Create a book from markdown files"
HOMEPAGE="https://rust-lang.github.io/mdBook/"
SRC_URI="https://github.com/rust-lang/mdBook/tarball/3f4f287e6e5437d83a6e1e6414739a57e4409767 -> mdBook-0.4.42-3f4f287.tar.gz
https://direct.funtoo.org/4a/b9/ec/4ab9ecf1b026d690e1e5984677165bae915741fd2f9ef262f7a82feb5c73dbc23e2eab0e85734fba50aa66fd9178dfb4882baec61092132468d2499a7b1b9ef6 -> mdbook-0.4.42-funtoo-crates-bundle-5d5d4e7c83fd31079e90d1bcccf62f6be4abf27f1a4db08ce64003a3f33ae116171dcd7a94189c9fc2e5c9d955c665edd691e43d2cf55b30fefdcaf7d4e5d8d9.tar.gz"
S="${WORKDIR}/rust-lang-mdBook-3f4f287"

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