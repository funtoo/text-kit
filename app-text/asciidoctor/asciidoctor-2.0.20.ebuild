# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby27 ruby30 ruby31 ruby32"

RUBY_FAKEGEM_TASK_TEST="CUCUMBER_PUBLISH_QUIET=true test features"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.adoc README.adoc"

RUBY_FAKEGEM_EXTRAINSTALL="data"

RUBY_FAKEGEM_GEMSPEC="asciidoctor.gemspec"

inherit ruby-fakegem

DESCRIPTION="Processor for converting AsciiDoc into HTML 5, DocBook 4.5 and other formats"
HOMEPAGE="https://github.com/asciidoctor/asciidoctor"
SRC_URI="https://github.com/asciidoctor/asciidoctor/tarball/840bd52ef0414eb09e089fbfa2013b687af6876e -> asciidoctor-2.0.20-840bd52.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE=""

ruby_add_bdepend "test? (
	dev-util/cucumber
	dev-ruby/rspec-expectations:*
	dev-ruby/asciimath
	dev-ruby/coderay
	dev-ruby/concurrent-ruby
	dev-ruby/erubis
	dev-ruby/haml
	dev-ruby/nokogiri
	dev-ruby/rouge
	dev-ruby/slim
	dev-ruby/tilt )"

post_src_unpack() {
	mv "${WORKDIR}"/all/asciidoctor-asciidoctor* "${WORKDIR}"/all/${P}
}

all_ruby_prepare() {
	rm Gemfile || die

	sed -i -e "s:_relative ': './:" ${RUBY_FAKEGEM_GEMSPEC} || die
}

all_ruby_install() {
	all_fakegem_install

	doman man/asciidoctor.1
}