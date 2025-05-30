# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517="setuptools"
DISTUTILS_OPTIONAL="1"

inherit bash-completion-r1 distutils-r1 meson

DESCRIPTION="A lightweight, fast implementation of DEC SIXEL graphics codec"
HOMEPAGE="https://github.com/libsixel/libsixel"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT public-domain"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~hppa ~loong ppc ppc64 ~riscv x86"
IUSE="curl gd gtk jpeg png python test"
RESTRICT="!test? ( test )"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="curl? ( net-misc/curl )
	gd? ( media-libs/gd )
	gtk? ( x11-libs/gdk-pixbuf:2 )
	jpeg? ( media-libs/libjpeg-turbo:= )
	png? ( media-libs/libpng:0 )
	python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	python? (
		${PYTHON_DEPS}
		${DISTUTILS_DEPS}
	)"

src_prepare() {
	sed -i '/^have/d' converters/shell-completion/bash/img2sixel

	default
	if use python; then
		cd python || die
		distutils-r1_src_prepare
		cd - >/dev/null || die
	fi
}

src_configure() {
	emesonargs=(
		$(meson_feature curl libcurl)
		$(meson_feature gd)
		$(meson_feature gtk gdk-pixbuf2)
		$(meson_feature jpeg)
		$(meson_feature png)
		$(meson_feature test tests)
		-Dbashcompletiondir="$(get_bashcompdir)"
	)
	meson_src_configure
	if use python; then
		cd python || die
		distutils-r1_src_configure
		cd - >/dev/null || die
	fi
}

src_compile() {
	meson_src_compile
	if use python; then
		cd python || die
		distutils-r1_src_compile
		cd - >/dev/null || die
	fi
}

src_install() {
	meson_src_install

	cd images || die
	docompress -x /usr/share/doc/${PF}/images
	docinto images
	dodoc egret.jpg map{8,16}.png snake.jpg vimperator3.png
	cd - >/dev/null || die

	if use python; then
		cd python || die
		distutils-r1_src_install
		cd - >/dev/null || die
	fi
}
