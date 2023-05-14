# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-1.0.1
anstream-0.3.2
anstyle-1.0.0
anstyle-parse-0.2.0
anstyle-query-1.0.0
anstyle-wincon-1.0.1
autocfg-1.1.0
bitflags-1.3.2
block-buffer-0.10.4
bstr-0.2.17
cc-1.0.79
cfg-if-1.0.0
clap-4.2.7
clap_builder-4.2.7
clap_derive-4.2.0
clap_lex-0.4.1
colorchoice-1.0.0
cpufeatures-0.2.7
crypto-common-0.1.6
digest-0.10.6
errno-0.3.1
errno-dragonfly-0.1.2
generic-array-0.14.7
handlebars-4.3.6
heck-0.4.1
hermit-abi-0.3.1
io-lifetimes-1.0.10
is-terminal-0.4.7
itoa-1.0.6
lazy_static-1.4.0
libc-0.2.142
linux-raw-sys-0.3.7
log-0.4.17
lua-src-544.0.1
luajit-src-210.4.5+resty2cf5186
memchr-2.5.0
mlua-0.8.8
num-traits-0.2.15
once_cell-1.17.1
pest-2.6.0
pest_derive-2.6.0
pest_generator-2.6.0
pest_meta-2.6.0
pkg-config-0.3.27
proc-macro2-1.0.56
quote-1.0.26
regex-1.8.1
regex-syntax-0.7.1
rustc-hash-1.1.0
rustix-0.37.19
ryu-1.0.13
serde-1.0.160
serde_json-1.0.96
sha2-0.10.6
strsim-0.10.0
syn-2.0.15
thiserror-1.0.40
thiserror-impl-1.0.40
typenum-1.16.0
ucd-trie-0.1.5
unicode-ident-1.0.8
utf8parse-0.2.1
version_check-0.9.4
windows-sys-0.48.0
windows-targets-0.48.0
windows_aarch64_gnullvm-0.48.0
windows_aarch64_msvc-0.48.0
windows_i686_gnu-0.48.0
windows_i686_msvc-0.48.0
windows_x86_64_gnu-0.48.0
windows_x86_64_gnullvm-0.48.0
windows_x86_64_msvc-0.48.0
yansi-0.5.1
"

inherit cargo

DESCRIPTION="Small command-line JSON Log viewer"
HOMEPAGE="https://github.com/brocode/fblog"
SRC_URI="https://api.github.com/repos/brocode/fblog/tarball/v4.4.0 -> fblog-4.4.0.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense WTFPL-2 ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=virtual/rust-1.34.2"

DOCS=( README.org sample.json.log )

QA_FLAGS_IGNORED="/usr/bin/fblog"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/brocode-fblog-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}