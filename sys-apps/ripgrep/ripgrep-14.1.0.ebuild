# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 cargo

DESCRIPTION="A search tool that combines the usability of ag with the raw speed of grep"
HOMEPAGE="https://github.com/BurntSushi/ripgrep"
SRC_URI="https://github.com/BurntSushi/ripgrep/tarball/e50df40a1967708b9781486b1c017e48040bceb0 -> ripgrep-14.1.0-e50df40.tar.gz
https://direct.funtoo.org/a9/20/df/a920df1d04501ce07838e91bcd9452a4bd38f76cd412a02cd60200571929c6b6e6f585952c09578561497718ea6fe0d8f73ce2f65f4dfa603f19367a36789d69 -> ripgrep-14.1.0-funtoo-crates-bundle-01af247b79057269c3cfadcf215f9c2a647c82d85f07f1416ed9815b4e8f86cc455e37c0b5e5cccde45b747809ae0e7546714ed9525162295aeea630d1296d9f.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="+man pcre"

DEPEND=""

RDEPEND="pcre? ( dev-libs/libpcre2 )"

BDEPEND="${RDEPEND}
	virtual/pkgconfig
	>=virtual/rust-1.34
	man? ( app-text/asciidoc )
"

QA_FLAGS_IGNORED="/usr/bin/ripgrep"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/BurntSushi-ripgrep-* ${S} || die
}

src_compile() {
	# allow building on musl with dynamic linking support
	# https://github.com/BurntSushi/rust-pcre2/issues/7
	use elibc_musl && export PCRE2_SYS_STATIC=0
	cargo_src_compile $(usex pcre "--features pcre2" "")
}

src_install() {
	cargo_src_install $(usex pcre "--features pcre2" "")

	# hack to find/install generated files
	# stamp file can be present in multiple dirs if we build additional features
	# so grab fist match only
	local BUILD_DIR="$(dirname $(find target/release -name ripgrep-stamp -print -quit))"

	if use man ; then
		newman - rg.1 <<-EOF
		$(target/$(usex debug debug release)/rg --generate man)
		EOF
	fi

	newbashcomp - rg <<-EOF
	$(target/$(usex debug debug release)/rg --generate complete-bash)
	EOF

	insinto /usr/share/fish/vendor_completions.d
	newins - rg.fish <<-EOF
	$(target/$(usex debug debug release)/rg --generate complete-fish)
	EOF

	insinto /usr/share/zsh/site-functions
	newins - _rg <<-EOF
	$(target/$(usex debug debug release)/rg --generate complete-zsh)
	EOF


	dodoc CHANGELOG.md FAQ.md GUIDE.md README.md
}