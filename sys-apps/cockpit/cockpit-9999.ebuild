# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit user pam autotools eutils git-r3

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
IUSE="+debug test +maintainer-mode doc"

REQUIRED_USE="maintainer-mode debug"

DEPEND=">=net-libs/libssh-0.6[server]
		>=dev-libs/json-glib-1.0.0
		>=sys-auth/polkit-0.105
		sys-apps/systemd[gudev]
		sys-fs/lvm2
		app-crypt/mit-krb5
		dev-util/gdbus-codegen
		sys-apps/pcp
		net-libs/nodejs[npm]
		app-admin/sudo
		doc? ( app-doc/xmlto )"

RDEPEND="${DEPEND}
        net-libs/glib-networking[ssl]"

pkg_setup(){
	if [ -z "$(egetent group cockpit-ws 2>/dev/null)" ]; then
		enewgroup cockpit-ws
		einfo
		einfo "The group 'cockpit-ws' has been created. Any users you add to this"
		einfo "group have access to files created by the daemons."
		einfo
	fi
	if [ -z "$(egetent passwd cockpit-ws 2>/dev/null)" ]; then
		enewuser cockpit-ws -1 -1 /var/lib/cockpit cockpit-ws
		einfo
		einfo "The user 'cockpit-ws' has been created."
		einfo
	fi
}
src_prepare() {
	epatch_user
	eautoreconf

	pushd  ${S}/tools
	einfo "Insalling nodejs packages"
	npm install || die "Couldn't install nodejs modules"
	popd 
}

src_configure() {
	local myconf="
		--localstatedir="${ROOT}/var"
		$(use_enable maintainer-mode)  
		$(use_enable debug) 
		$(use_enable doc)
		--with-pamdir=/lib64/security
		--with-cockpit-user=cockpit-ws  
		--with-cockpit-group=cockpit-ws"
	econf $myconf
}
src_install(){
	emake DESTDIR=${D}  install || die "emake install failed"
	ewarn "Installing experimetal pam configuration file"
	ewarn "use at your own risk"
	newpamd "${FILESDIR}/cockpit.pam" cockpit
	dodoc README.md AUTHORS
}
