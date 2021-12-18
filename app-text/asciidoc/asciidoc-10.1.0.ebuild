# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ pypy )
inherit distutils-r1

DESCRIPTION="AsciiDoc is a text document format for writing things."
HOMEPAGE="https://github.com/asciidoc/asciidoc-py3 https://pypi.org/project/asciidoc/"
SRC_URI="https://files.pythonhosted.org/packages/c3/b6/f874a6e5ecfb7192a0199dd7652a7a8401a52090e3f6bf4a07b7b76a92ae/asciidoc-10.1.0.tar.gz
"

DEPEND=""
RDEPEND="
	app-text/docbook-xml-dtd:4.5
	>=app-text/docbook-xsl-stylesheets-1.75
	dev-libs/libxslt
	dev-libs/libxml2:2"

IUSE=""
SLOT="0"
LICENSE="MIT"
KEYWORDS="*"

S="${WORKDIR}/asciidoc-10.1.0"