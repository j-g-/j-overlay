# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils git-r3

DESCRIPTION="Server Administration Web Interface "
HOMEPAGE="http://cockpit-project.org/"
SRC_URI=""

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cockpit-project/cockpit.git"
	KEYWORDS=""
fi

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE="+debug test +maintainer-mode"

REQUIRED_USE="maintainer-mode debug"

DEPEND=">=net-libs/libssh-0.6[server]
		sys-apps/pcp
		net-libs/nodejs[npm]"

RDEPEND="${DEPEND}"

pkg_setup(){
	if [ -z "$(egetent group cockpit-ws 2>/dev/null)" ]; then
		enewgroup cockpit-ws
		einfo
		einfo "The group 'cockpit-ws' has been created. Any users you add to this"
		einfo "group have access to files created by the daemons."
		einfo
	fi
	if [ -z "$(egetent passwd cockpit-ws 2>/dev/null)" ]; then
		enewuser cockpit-ws -1 -1 -1 cockpit-ws
		einfo
		einfo "The user 'cockpit-ws' has been created."
		einfo
	fi
}
src_prepare() {
	epatch_user
	eautoreconf
	pushd  ${S}/tools
	touch .npmrc
	npm install || die "Couldn't install nodejs modules"
	popd ${S}
}

src_configure() {
	local myconf="
		$(use_enable maintainer-mode) \ 
		$(use_enable debug) \ 	
		--with-cockpit-user=cockpit-ws \ 
		--with-cockpit-group=cockpit-ws"
	econf $myconf
}

