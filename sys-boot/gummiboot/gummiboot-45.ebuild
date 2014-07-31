# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit  linux-info

DESCRIPTION="Minimalistic UEFI bootloader"
HOMEPAGE="http://freedesktop.org/wiki/Software/gummiboot/"
SRC_URI="http://cgit.freedesktop.org/gummiboot/snapshot/gummiboot-45.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-boot/gnu-efi-3.0"
RDEPEND="${DEPEND}"

src_prepare() {
	./autogen.sh
}

pkg_pretend() {
	# CONFIG_EFI_STUB  is required to boot a kernel with gummiboot
	local CONFIG_CHECK="~EFI_STUB"
	check_extra_config
}
