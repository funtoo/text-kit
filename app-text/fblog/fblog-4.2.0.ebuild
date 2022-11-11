# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.7.19
atty-0.2.14
autocfg-1.1.0
bitflags-1.3.2
block-buffer-0.10.3
bstr-0.2.17
cc-1.0.73
cfg-if-1.0.0
clap-4.0.10
clap_derive-4.0.10
clap_lex-0.3.0
cpufeatures-0.2.5
crypto-common-0.1.6
digest-0.10.5
generic-array-0.14.6
handlebars-4.3.4
heck-0.4.0
hermit-abi-0.1.19
itoa-1.0.3
lazy_static-1.4.0
libc-0.2.134
log-0.4.17
lua-src-544.0.1
luajit-src-210.4.3+resty8384278
memchr-2.5.0
mlua-0.8.3
num-traits-0.2.15
once_cell-1.15.0
os_str_bytes-6.3.0
pest-2.4.0
pest_derive-2.4.0
pest_generator-2.4.0
pest_meta-2.4.0
pkg-config-0.3.25
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.46
quote-1.0.21
regex-1.6.0
regex-syntax-0.6.27
rustc-hash-1.1.0
ryu-1.0.11
serde-1.0.145
serde_json-1.0.85
sha1-0.10.5
strsim-0.10.0
syn-1.0.101
termcolor-1.1.3
thiserror-1.0.37
thiserror-impl-1.0.37
typenum-1.15.0
ucd-trie-0.1.5
unicode-ident-1.0.4
version_check-0.9.4
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
yansi-0.5.1
"

inherit cargo

DESCRIPTION="Small command-line JSON Log viewer"
HOMEPAGE="https://github.com/brocode/fblog"
SRC_URI="https://api.github.com/repos/brocode/fblog/tarball/v4.2.0 -> fblog-4.2.0.tar.gz
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