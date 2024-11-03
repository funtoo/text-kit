# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Small command-line JSON Log viewer"
HOMEPAGE="https://github.com/brocode/fblog"
SRC_URI="https://github.com/brocode/fblog/tarball/b0ce9dd644c850f5da044d62abfda09d25964392 -> fblog-4.13.1-b0ce9dd.tar.gz
https://direct.funtoo.org/3f/52/e5/3f52e56ddcca80a240e70be367bc262e05d5b6141faaacaa9469321b5c7a1aaa62907a97764dd1d8887eb4daec6b45103480ccf33e368806f4835638786e1e9e -> fblog-4.13.1-funtoo-crates-bundle-af581006f28a2e07637b6c1803f9e9dcf78a384e3cddd1e330a2eb9296170aaacaf312f9a86bee8c3fe67816ed4eb2609fa0d622beb24be89201646b320fec2f.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense WTFPL-2 ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="virtual/rust"

DOCS=(
	README.md
	sample.json.log
	sample_context.log
	sample_nested.json.log
	sample_numbered.json.log
)

QA_FLAGS_IGNORED="/usr/bin/fblog"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/brocode-fblog-* ${S} || die
}