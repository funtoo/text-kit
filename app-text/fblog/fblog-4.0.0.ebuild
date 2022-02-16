# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.7.18
ansi_term-0.12.1
atty-0.2.14
autocfg-1.0.1
bitflags-1.3.2
block-buffer-0.7.3
block-padding-0.1.5
bstr-0.2.17
byte-tools-0.3.1
byteorder-1.4.3
cc-1.0.72
cfg-if-1.0.0
clap-3.0.13
digest-0.8.1
fake-simd-0.1.2
generic-array-0.12.4
handlebars-4.2.1
hashbrown-0.11.2
hermit-abi-0.1.19
indexmap-1.8.0
itoa-1.0.1
lazy_static-1.4.0
libc-0.2.116
log-0.4.14
lua-src-544.0.0
luajit-src-210.3.2+resty1085a4d
maplit-1.0.2
memchr-2.4.1
mlua-0.7.3
num-traits-0.2.14
once_cell-1.9.0
opaque-debug-0.2.3
os_str_bytes-6.0.0
pest-2.1.3
pest_derive-2.1.0
pest_generator-2.1.3
pest_meta-2.1.3
pkg-config-0.3.24
proc-macro2-1.0.36
quick-error-2.0.1
quote-1.0.15
regex-1.5.4
regex-syntax-0.6.25
rustc-hash-1.1.0
ryu-1.0.9
serde-1.0.136
serde_json-1.0.78
sha-1-0.8.2
strsim-0.10.0
syn-1.0.86
termcolor-1.1.2
textwrap-0.14.2
typenum-1.15.0
ucd-trie-0.1.3
unicode-xid-0.2.2
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="Small command-line JSON Log viewer"
HOMEPAGE="https://github.com/brocode/fblog"
SRC_URI="https://api.github.com/repos/brocode/fblog/tarball/v4.0.0 -> fblog-4.0.0.tar.gz
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