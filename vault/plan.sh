pkg_origin=epcim
pkg_name=vault
<<<<<<< Updated upstream
pkg_version=1.1.1
||||||| merged common ancestors
pkg_version=1.1.0
=======
pkg_version=1.0.2
>>>>>>> Stashed changes
pkg_description="A tool for managing secrets."
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("MPL-2.0")
pkg_upstream_url=https://www.vaultproject.io/
pkg_source="https://releases.hashicorp.com/vault/${pkg_version}/vault_${pkg_version}_linux_amd64.zip"
<<<<<<< Updated upstream
pkg_shasum=134261417c8129a92992cba75bf7ebce8ee4d6100de18b722cce7507782e272c
||||||| merged common ancestors
pkg_shasum=65d665ee7ba08fb41a7113a2ae3c1d5fd7e0b530b59644ed7dc8a01870b2d73f
=======
pkg_shasum=5549714c24b61ea77a7afb30e1fbff6ec596cfd39dab7a2e6cf7e71432d616cc
>>>>>>> Stashed changes
pkg_filename="${pkg_name}-${pkg_version}_linux_amd64.zip"
pkg_deps=()
pkg_build_deps=(core/unzip)
pkg_bin_dirs=(bin)
pkg_svc_user=root
pkg_svc_group=root
pkg_exports=(
  [port]=listener.port
)
pkg_exposes=(port)

do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  unzip "${pkg_filename}" -d "${pkg_name}-${pkg_version}"
}

do_build() {
  return 0
}

do_install() {
  install -D vault "${pkg_prefix}"/bin/vault
}
