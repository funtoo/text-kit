# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ pypy )
inherit distutils-r1

DESCRIPTION="AsciiDoc is a text document format for writing things."
HOMEPAGE="https://github.com/asciidoc/asciidoc-py3 https://pypi.org/project/asciidoc/"
SRC_URI="https://files.pythonhosted.org/packages/45/f0/05c069f44f22da7737cec85b067b79e6c2bd29db66e0f13ebb67e8ea51b3/asciidoc-10.1.2.tar.gz
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

S="${WORKDIR}/asciidoc-10.1.2"