# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="xml(+),threads(+)"

inherit eutils python-single-r1 python-utils-r1 waf-utils

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/projecthamster/${PN}"
	KEYWORDS=""
fi

DESCRIPTION="Gnome time tracker"
HOMEPAGE="https://github.com/projecthamster/hamster"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPEND}
		>=x11-libs/gtk+-3.10:3[introspection]
		dev-python/gconf-python[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
		sys-devel/gettext
		app-text/docbook-sgml-utils"

# TODO: remove  unset linguas. 
# before build or after installation?

pkg_setup() { 
	python-single-r1_pkg_setup 
}
src_prepare() {
	epatch_user
}

src_install() {
	waf-utils_src_install
	python_fix_shebang "${ED}"usr/bin
	python_fix_shebang "${ED}"usr/lib64/hamster-time-tracker
}
