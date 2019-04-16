pkg_name=vesbox-ipxe
pkg_origin=epcim
pkg_version="v0.1.0"
pkg_maintainer="Petr Michalec <pmichalec@ves.io>"
pkg_license=("Apache-2.0")
#pkg_source="http://some_source_url/releases/${pkg_name}-${pkg_version}.tar.gz"

# ${pkg_version} or 1.15.11
pkg_deps=(core/nginx/1.15.11)

# pkg_build_deps=(core/make core/gcc)
# pkg_lib_dirs=(lib)
# pkg_include_dirs=(include)
# pkg_bin_dirs=(bin)
# pkg_pconfig_dirs=(lib/pconfig)
# pkg_svc_run="haproxy -f $pkg_svc_config_path/haproxy.conf"
# pkg_exports=(
#   [host]=srv.address
#   [port]=srv.port
#   [ssl-port]=srv.ssl.port
# )
# pkg_exposes=(port ssl-port)
# pkg_binds=(
#   [database]="port host"
# )
# pkg_binds_optional=(
#   [storage]="port host"
# )
# pkg_interpreters=(bin/bash)
# pkg_svc_user="hab"
# pkg_svc_group="$pkg_svc_user"
# pkg_description="Some description."
# pkg_upstream_url="http://example.com/project-name"


do_download() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  return 0
}
