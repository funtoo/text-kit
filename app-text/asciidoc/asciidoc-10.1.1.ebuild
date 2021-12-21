# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ pypy )
inherit distutils-r1

DESCRIPTION="AsciiDoc is a text document format for writing things."
HOMEPAGE="https://github.com/asciidoc/asciidoc-py3 https://pypi.org/project/asciidoc/"
SRC_URI="https://files.pythonhosted.org/packages/4b/c0/ded4666a6d7a978b50fda85f44ba7f0939bd92838102769eca91a769aa9f/asciidoc-10.1.1.tar.gz
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

S="${WORKDIR}/asciidoc-10.1.1"