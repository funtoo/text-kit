# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="git://github.com/matimatik/fbless.git"
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="ncurses,xml"
inherit distutils-r1 git-r3

DESCRIPTION="Python-based console fb2 reader with less-like interface"
HOMEPAGE="https://github.com/matimatik/fbless"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
