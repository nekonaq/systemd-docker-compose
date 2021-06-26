class systemd_docker_compose(
  Variant[String, Boolean, Undef] $ensure = present,
  Optional[Hash] $settings = {},
) inherits systemd_docker_compose::params {
  notice('---')

  $use_settings = $systemd_docker_compose::params::settings + std::nv($settings, Hash, {})
  info(std::pp({'use_settings' => $use_settings}))

  $file_ensure = std::file_ensure($ensure)

  file { 'systemd_docker_compose::template':
    path => "${stdapp::systemd_unit_dir}/docker-compose@.service",
    ensure => $file_ensure,
    content => epp('systemd_docker_compose/docker-compose@.service', $use_settings),
    notify => Exec[systemd::reload],
  }
}
