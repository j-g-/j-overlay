# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit font
#MY_PN="${PN/d/D}"
DESCRIPTION="Anka/Coder Family Fonts"
HOMEPAGE="http://code.google.com/p/anka-coder-fonts/"
SRC_URI="http://anka-coder-fonts.googlecode.com/files/AnkaCoder.zip	
	http://anka-coder-fonts.googlecode.com/files/AnkaCoderCondensed.zip
	http://anka-coder-fonts.googlecode.com/files/AnkaCoderNarrow.zip"
LICENSE="OFL"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND=">=app-arch/unzip-4.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}
FONT_S=${S}
FONT_SUFFIX="ttf"
FONT_CONF={"$FILESDIR/99-ankcacoder.conf"}
src_unpack() {

	unpack ${A} || die "culdn't upcack"
	echo "Files extracted: "
	ls -laR

}

src_install(){
	mkdir -p "$WORKDIR/usr/share/fonts/$PN"
	insinto "/usr/share/fonts/$PN"
	
	doins ${WORKDIR}/*.ttf || die "Culdn't install" 

	font_xfont_config
	font_fontconfig

}
