# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

MY_P=${P/_beta/-b}
DESCRIPTION="Multipurpose relay (SOcket CAT)"
HOMEPAGE="http://www.dest-unreach.org/socat/ https://repo.or.cz/socat.git"
SRC_URI="http://www.dest-unreach.org/socat/download/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~arm64 ~hppa ~ia64 ~loong ~m68k ~mips ~ppc ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"
IUSE="bindist ipv6 readline ssl tcpd"

DEPEND="ssl? ( dev-libs/openssl:0= )
	readline? ( sys-libs/readline:= )
	tcpd? ( sys-apps/tcp-wrappers )"
RDEPEND="${DEPEND}"

# Tests are a large bash script
# Hard to disable individual tests needing network or privileges
# in 1.7.4.2: FAILED:  59 329
RESTRICT="test ssl? ( readline? ( bindist ) )"

DOCS=( BUGREPORTS CHANGES DEVELOPMENT EXAMPLES FAQ FILES PORTING README SECURITY )

pkg_setup() {
	# bug #587740
	if use readline && use ssl ; then
		elog "You are enabling both readline and ssl (openssl) USE flags, the licenses"
		elog "for these packages conflict. You may not be able to legally"
		elog "redistribute the resulting binary."
	fi
}

src_configure() {
	# bug #293324
	filter-flags '-Wno-error*'

	tc-export AR

	econf \
		$(use_enable ssl openssl) \
		$(use_enable readline) \
		$(use_enable ipv6 ip6) \
		$(use_enable tcpd libwrap)
}

src_install() {
	default

	docinto html
	dodoc doc/*.html doc/*.css
}
