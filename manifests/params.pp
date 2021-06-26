class systemd_docker_compose::params {
  include stdapp

  $value = parseyaml(file('systemd_docker_compose/params.yml'))
  $settings = std::nv($value['systemd_docker_compose::settings'], Hash, {})
}
