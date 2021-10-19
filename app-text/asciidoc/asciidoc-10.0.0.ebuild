# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ pypy )
inherit distutils-r1

DESCRIPTION="AsciiDoc is a text document format for writing things."
HOMEPAGE="https://github.com/asciidoc/asciidoc-py3 https://pypi.org/project/asciidoc/"
SRC_URI="https://files.pythonhosted.org/packages/6b/26/d2828867b366b73fc55b5ed51d7ad369195cc51d6293875ac152aa4b1742/asciidoc-10.0.0.tar.gz
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

S="${WORKDIR}/asciidoc-10.0.0"