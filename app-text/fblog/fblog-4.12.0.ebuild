# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Small command-line JSON Log viewer"
HOMEPAGE="https://github.com/brocode/fblog"
SRC_URI="https://github.com/brocode/fblog/tarball/c355fc82f0eca79008be1978f5facfaba55457ad -> fblog-4.12.0-c355fc8.tar.gz
https://direct.funtoo.org/c9/d0/fd/c9d0fdea23b6e48def5204b7f5eae61aa1b58f412efb06fea4a95e87072d782b94e1105bfe6c584c0b3fb3dbe741625b1ceb042eeccc15406a44b2e2fe771e17 -> fblog-4.12.0-funtoo-crates-bundle-a2e530d457760a81bb48f6f0820d2d1b35b59797c86bebb8b8dd9820fbeb9bfbce2022a47835ade14f2bfb5b89875b7267630175bf1286afe32e84a8f4f2f1cf.tar.gz"

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