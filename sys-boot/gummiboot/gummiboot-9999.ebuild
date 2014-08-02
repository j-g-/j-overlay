# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
inherit linux-info git-r3


DESCRIPTION="Minimalistic UEFI bootloader"
HOMEPAGE="http://freedesktop.org/wiki/Software/gummiboot/"
EGIT_REPO_URI="git://anongit.freedesktop.org/${PN}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-boot/gnu-efi-3.0"
RDEPEND="${DEPEND}"

src_prepare() {
	./autogen.sh || die "autogen failed"
}

pkg_pretend() {
	# CONFIG_EFI_STUB  is required to boot a kernel with gummiboot
	local CONFIG_CHECK="~EFI_STUB"
	check_extra_config
}
