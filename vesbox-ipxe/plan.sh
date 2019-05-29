pkg_name=vesbox-ipxe
pkg_origin=epcim
pkg_version="v0.1.12"
pkg_maintainer="Petr Michalec <pmichalec@ves.io>"
pkg_license=("Apache-2.0")
#pkg_source="http://some_source_url/releases/${pkg_name}-${pkg_version}.tar.gz"
pkg_deps=(
  core/nginx
  core/curl
)


pkg_svc_run="nginx -c ${pkg_svc_config_path}/nginx.conf"
pkg_svc_user="root"
pkg_exports=(
  [port]=http.listen.port
)
pkg_exposes=(port)


do_download() {
  return 0
}

do_build() {
  return 0
}

do_install() {
 return 0
}
