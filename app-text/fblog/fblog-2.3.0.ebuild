# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.7.13
ansi_term-0.11.0
ansi_term-0.12.1
atty-0.2.14
bitflags-1.2.1
block-buffer-0.7.3
block-padding-0.1.5
byte-tools-0.3.1
byteorder-1.3.4
cc-1.0.59
cfg-if-0.1.10
clap-2.33.3
digest-0.8.1
fake-simd-0.1.2
generic-array-0.12.3
handlebars-3.4.0
hermit-abi-0.1.15
hlua-0.4.1
itoa-0.4.6
lazy_static-1.4.0
libc-0.2.76
log-0.4.11
lua52-sys-0.1.2
maplit-1.0.2
memchr-2.3.3
opaque-debug-0.2.3
pest-2.1.3
pest_derive-2.1.0
pest_generator-2.1.3
pest_meta-2.1.3
pkg-config-0.3.18
proc-macro2-1.0.19
quick-error-2.0.0
quote-1.0.7
regex-1.3.9
regex-syntax-0.6.18
ryu-1.0.5
serde-1.0.115
serde_json-1.0.57
sha-1-0.8.2
strsim-0.8.0
syn-1.0.39
textwrap-0.11.0
thread_local-1.0.1
typenum-1.12.0
ucd-trie-0.1.3
unicode-width-0.1.8
unicode-xid-0.2.1
vec_map-0.8.2
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="Small command-line JSON Log viewer"
HOMEPAGE="https://github.com/brocode/fblog"
SRC_URI="https://api.github.com/repos/brocode/fblog/tarball/v2.3.0 -> fblog-2.3.0.tar.gz
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