# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit eutils java-pkg-2

MY_PN=${PN%%-bin}
DESCRIPTION="DIagrams Through Ascii Art"
HOMEPAGE="http://ditaa.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${MY_PN}/${MY_PN}/${PV}/${MY_PN}${PV/./_}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	>=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

src_compile() { :; }

src_install() {
	java-pkg_newjar ${MY_PN}${PV/./_}.jar ${MY_PN}.jar || die
	java-pkg_dolauncher ${MY_PN} || die
	dodoc HISTORY || die
}
