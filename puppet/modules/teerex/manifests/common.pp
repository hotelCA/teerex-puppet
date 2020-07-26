class teerex::common {
  $home_dir = $facts['windows_env']['USERPROFILE']
  $suite_dir = "${home_dir}/Genie Suite"

  file { "${suite_dir}":
    ensure => 'directory',
  } ->
  file { "${suite_dir}/logs":
    ensure => 'directory',
  } ->
  file { "${suite_dir}/Designs":
    ensure => 'directory',
  } ->
  file { "${suite_dir}/Designs_ARX4":
    ensure => 'directory',
  } ->
  exec { 'run_sciprt':
    command => "${home_dir}/teerex-puppet/Design_Loader/Design_Loader.exe",
  }
}

