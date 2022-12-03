# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )

inherit python-r1

DESCRIPTION="Spell checking, hyphenation and morphological analysis tool for Finnish language"
HOMEPAGE="https://voikko.puimula.org/"
SRC_URI="https://github.com/voikko/corevoikko/tarball/55f8a46e11032d20f9b2d0ad84d02ba892336668 -> corevoikko-4.3.1-55f8a46.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"

IUSE="+expvfst +hfst"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"

DEPEND="${PYTHON_DEPS}
	hfst? ( >=dev-util/hfstospell-0.5.0 )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/voikko-* "${S}"

	S="${S}"/libvoikko
}

src_configure() {
	./autogen.sh || die
	local myconf=(
		--prefix=/usr
		--with-dictionary-path=/usr/share/voikko
		$(use_enable expvfst)
	)

	if ! use hfst ; then
		myconf+=( --disable-hfst )
	fi

	econf "${myconf[@]}"
}

src_install() {
	python_setup
	default

	python_foreach_impl python_domodule python/libvoikko.py

	find "${D}" -name '*.la' -delete -o -name '*.a' -delete || die
}