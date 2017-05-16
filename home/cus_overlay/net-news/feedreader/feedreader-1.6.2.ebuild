# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit cmake-utils gnome2 vala

CMAKE_MIN_VERSION="2.6"
VALA_MIN_API_VERSION="0.26"

DESCRIPTION="A modern desktop application designed to complement web-based RSS accounts."
HOMEPAGE="https://jangernert.github.io/FeedReader/"
SRC_URI="https://github.com/jangernert/FeedReader/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-3.20:3
	app-text/html2text
	$(vala_depend)
	dev-libs/json-glib
	dev-libs/libgee:0.8
	dev-libs/libpeas
	net-libs/libsoup:2.4
	dev-db/sqlite:3
	app-crypt/libsecret[vala(+)]
	x11-libs/libnotify
	dev-libs/libxml2
	net-libs/rest:0.7
	net-misc/curl
	dev-libs/gobject-introspection
	gnome-base/gnome-keyring
	net-libs/gnome-online-accounts
	media-libs/gst-plugins-base:1.0
	>=net-libs/webkit-gtk-2.10:4"

DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

S="${WORKDIR}/FeedReader-${PV}"

src_prepare() {
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_LIBUNITY=OFF
		-DVALA_EXECUTABLE="${VALAC}"
		-DCMAKE_INSTALL_PREFIX="${PREFIX}"
		-DGSETTINGS_LOCALINSTALL=OFF
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}

pkg_preinst() {
	gnome2_pkg_preinst
}

pkg_postinst() {
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
}
