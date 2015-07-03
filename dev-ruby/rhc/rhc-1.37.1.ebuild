# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"
inherit bash-completion-r1 ruby-fakegem

RUBY_FAKEGEM_EXTRADOC="Readme.md"
DESCRIPTION=" Command line interface for OpenShift."
HOMEPAGE="https://github.com/openshift/rhc"
SRC_URI="https://github.com/openshift/rhc/archive/rhc-1.37.1-1.tar.gz -> ${P}.tar.gz"
RUBY_S="${PN}-${P}-1"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
ruby_add_rdepend "<dev-ruby/net-ssh-2.9.3"
ruby_add_rdepend "dev-ruby/commander"
ruby_add_rdepend ">=dev-ruby/net-scp-1.1.2"
ruby_add_rdepend ">=dev-ruby/net-ssh-multi-1.2.0"
ruby_add_rdepend ">=dev-ruby/httpclient-2.4.0"
ruby_add_rdepend "dev-ruby/open4"
ruby_add_rdepend "dev-ruby/archive-tar-minitar"
ruby_add_rdepend ">=dev-ruby/highline-1.6.11"

all_ruby_install() {
	doman man/rhc.1
	doman man/express.conf.5
	newbashcomp autocomplete/rhc_bash ${PN}
}
