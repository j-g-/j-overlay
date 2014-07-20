# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Minimalistic UEFI bootloader"
HOMEPAGE="http://freedesktop.org/wiki/Software/gummiboot/"

SRC_URI="http://cgit.freedesktop.org/gummiboot/snapshot/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-boot/gnu-efi"
RDEPEND="${DEPEND}"
src_prepare () {
	./autogen.sh
}

