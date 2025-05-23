# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic optfeature toolchain-funcs

DESCRIPTION="An easy to use text-based based mail and news client"
HOMEPAGE="https://alpineapp.email/ https://repo.or.cz/alpine.git/"
SRC_URI="https://alpineapp.email/alpine/release/src/${P}.tar.xz
	https://www.applied-asynchrony.com/distfiles/${P}-patches-1.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ~ppc64 ~sparc x86"
IUSE="+chappa ipv6 kerberos ldap nls onlyalpine passfile smime ssl"

DEPEND="sys-libs/ncurses:=
	virtual/libcrypt:=
	kerberos? ( app-crypt/mit-krb5 )
	ldap? ( net-nds/openldap:= )
	ssl? ( dev-libs/openssl:0= )
"
RDEPEND="${DEPEND}
	app-misc/mime-types
"

src_prepare() {
	default

	# apply patches from upstream git to fix compiler issues
	eapply "${WORKDIR}"/${P}-patches/0*.patch

	# optional extra features, see https://alpineapp.email/alpine/index.html
	use chappa && eapply "${WORKDIR}/${P}-patches/chappa-rebased.patch"

	# fix gettext macros to work with >=0.23 (bug #946128)
	# eautoreconf will call autopoint, which will install any necessary files
	# from the version we set in configure.ac
	local gettext_version=$(gettextize --version | awk '/GNU gettext-tools/{print $NF}' || die)
	sed -i "s/^AM_GNU_GETTEXT_VERSION(.*)/AM_GNU_GETTEXT_VERSION([${gettext_version}])/g" configure.ac || die

	# do not override $RM for libtool (bug #880323)
	sed -i "/^AC_PATH_PROG(RM/d" configure.ac || die

	eautoreconf
	tc-export CC RANLIB AR
	export CC_FOR_BUILD="$(tc-getBUILD_CC)"
}

src_configure() {
	myconf=(
		--without-tcl
		--with-pthread
		--with-system-pinerc="${EPREFIX}"/etc/pine.conf
		--with-system-fixed-pinerc="${EPREFIX}"/etc/pine.conf.fixed
		$(use_with ldap)
		$(use_with ssl)
		$(use_with passfile passfile .pinepwd)
		$(use_with kerberos krb5)
		$(use_enable nls)
		$(use_with ipv6)
		$(use_with smime)
	)

	if has_version "app-text/hunspell"; then
		myconf+=( --with-interactive-spellcheck=/usr/bin/hunspell )
	elif has_version "app-text/aspell"; then
		myconf+=( --with-interactive-spellcheck=/usr/bin/aspell )
	fi

	if use ssl; then
		myconf+=(
			--with-ssl-include-dir="${EPREFIX}"/usr/include/openssl
			--with-ssl-lib-dir="${EPREFIX}"/usr/$(get_libdir)
			--with-ssl-certs-dir="${EPREFIX}"/etc/ssl/certs
		)
	fi

	# Bug 935343; see imap/docs/bugs.txt
	if use ipv6; then
		sed -i "s/IP=4/IP=6/" imap/Makefile || die
	fi

	# dial down warnings about unused results
	append-flags -Wno-unused-result

	econf "${myconf[@]}"
}

src_compile() {
	# the bundled c-client lib stumbles with both -j>1 and --shuffle #888709
	emake -j1 --shuffle=none AR="$(tc-getAR)" c-client
	emake AR="$(tc-getAR)"
}

src_install() {
	if use onlyalpine ; then
		dobin alpine/alpine
		doman doc/man1/alpine.1
	else
		emake -j1 DESTDIR="${D}" install
		doman doc/man1/*.1
	fi
	dodoc NOTICE README*
	dodoc doc/brochure.txt
	dodoc -r doc/tech-notes/
	newdoc "${S}/doc/mailcap.unx" mailcap.unx.sample
	newdoc "${S}/doc/mime.types" mime.types.sample
	docompress -x /usr/share/doc/${PF}/mailcap.unx.sample /usr/share/doc/${PF}/mime.types.sample
}

pkg_postinst() {
	optfeature "Spell checking" app-text/hunspell app-text/aspell
}
