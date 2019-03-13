pkg_name=coredns
pkg_origin=epcim
pkg_version="1.2.0"
pkg_maintainer="Jonathan Tron <jonathan@tron.name>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/coredns/coredns/releases/download/v${pkg_version}/coredns_${pkg_version}_linux_amd64.tgz"
pkg_shasum="ba5bc542f2652774ee9f8b5ac6486a469db351031c50fa5a0aa5d33390f7a60a"
pkg_deps=(core/cacerts)
pkg_build_deps=()
pkg_bin_dirs=(bin)
pkg_svc_user="root"
pkg_exports=(
  [port]=port
  [prometheus_port]=prometheus_port
)
pkg_exposes=(port prometheus_port)

do_build() {
  return 0
}

do_install(){
  cp ../coredns ${pkg_prefix}/bin/
}
