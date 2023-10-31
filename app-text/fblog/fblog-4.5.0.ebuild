# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-1.1.2
anstream-0.6.4
anstyle-1.0.4
anstyle-parse-0.2.2
anstyle-query-1.0.0
anstyle-wincon-3.0.1
autocfg-1.1.0
bitflags-2.4.1
block-buffer-0.10.4
bstr-1.7.0
cc-1.0.83
cfg-if-1.0.0
clap-4.4.7
clap_builder-4.4.7
clap_derive-4.4.7
clap_lex-0.6.0
colorchoice-1.0.0
cpufeatures-0.2.11
crypto-common-0.1.6
digest-0.10.7
either-1.9.0
errno-0.3.5
generic-array-0.14.7
handlebars-4.4.0
heck-0.4.1
home-0.5.5
itoa-1.0.9
lazy_static-1.4.0
libc-0.2.149
linux-raw-sys-0.4.10
log-0.4.20
lua-src-546.0.1
luajit-src-210.4.8+resty107baaf
memchr-2.6.4
mlua-0.9.1
mlua-sys-0.3.2
num-traits-0.2.17
once_cell-1.18.0
pest-2.7.5
pest_derive-2.7.5
pest_generator-2.7.5
pest_meta-2.7.5
pkg-config-0.3.27
proc-macro2-1.0.69
quote-1.0.33
regex-1.10.2
regex-automata-0.4.3
regex-syntax-0.8.2
rustc-hash-1.1.0
rustix-0.38.21
ryu-1.0.15
serde-1.0.190
serde_derive-1.0.190
serde_json-1.0.108
sha2-0.10.8
strsim-0.10.0
syn-2.0.38
thiserror-1.0.50
thiserror-impl-1.0.50
typenum-1.17.0
ucd-trie-0.1.6
unicode-ident-1.0.12
utf8parse-0.2.1
version_check-0.9.4
which-4.4.2
windows-sys-0.48.0
windows-targets-0.48.5
windows_aarch64_gnullvm-0.48.5
windows_aarch64_msvc-0.48.5
windows_i686_gnu-0.48.5
windows_i686_msvc-0.48.5
windows_x86_64_gnu-0.48.5
windows_x86_64_gnullvm-0.48.5
windows_x86_64_msvc-0.48.5
yansi-0.5.1
"

inherit cargo

DESCRIPTION="Small command-line JSON Log viewer"
HOMEPAGE="https://github.com/brocode/fblog"
SRC_URI="https://api.github.com/repos/brocode/fblog/tarball/v4.5.0 -> fblog-4.5.0.tar.gz
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