# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} pypy3 )

inherit distutils-r1

DESCRIPTION="Extensible memoizing collections and decorators"
HOMEPAGE="
	https://github.com/tkem/cachetools/
	https://pypi.org/project/cachetools/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 hppa ~ia64 ~ppc ppc64 ~riscv ~s390 sparc x86"

distutils_enable_tests pytest
