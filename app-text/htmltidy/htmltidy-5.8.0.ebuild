# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"
RUBY_OPTIONAL="yes"

inherit cmake ruby-ng

DESCRIPTION="The granddaddy of HTML tools, with support for modern standards"
HOMEPAGE="https://www.html-tidy.org/"
SRC_URI="https://github.com/htacg/tidy-html5/tarball/1ca37471b48a3498f985509828cb3cf85ea129f8 -> tidy-html5-5.8.0-1ca3747.tar.gz"

LICENSE="BSD"
SLOT="0/$(ver_cut 1)$(ver_cut 2)" # subslot is SOVERSION which is MAJORMINOR
KEYWORDS="*"
IUSE="deprecated test"
RESTRICT="!test? ( test )"

REQUIRED_USE="test? ( || ( $(ruby_get_use_targets) ) )"

DEPEND="test? ( $(ruby_implementations_depend) )"

PATCHES=(
	"${FILESDIR}"/${PN}-5.8.0-no_static_lib.patch
)

DOCS=( README.md README/CHANGELOG.md )

S="${WORKDIR}"/all/${P}

pkg_setup() {
	use test && ruby-ng_pkg_setup
}

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv all/htacg-tidy-html5* "${S}" || die
	fi
}

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DTIDY_CONSOLE_SHARED=ON
	)
	use deprecated && mycmakeargs+=(
		-DBUILD_TAB2SPACE=ON
		-DTIDY_COMPAT_HEADERS=ON
	)
	cmake_src_configure
}

src_test() {
	cd regression_testing || die
	rm -f Gemfile.lock
	${RUBY} ./test.rb test -t "${BUILD_DIR}/tidy" || die "Test execution failed"
}

src_install() {
	cmake_src_install
	use deprecated && dobin "${BUILD_DIR}"/tab2space
}