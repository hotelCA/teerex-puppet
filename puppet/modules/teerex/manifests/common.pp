class teerex::common {
  $home_dir = $facts['windows_env']['PROGRAMDATA']
  $puppet_checkout = 'teerex-puppet'
  $design_loader_checkout = 'teerex-design-loader'
  $print_genie_checkout = 'teerex-print-genie'
  $design_loader_tag = 'v1.0.1'
  $print_genie_tag = 'v1.0.2'
  $suite_dir = "${home_dir}\\Genie Suite"
  $puppet_dir = "C:\\Program Files\\Puppet Labs\\Puppet\\bin"

  teerex::checkout { 'puppet':
    checkout_project => $puppet_checkout,
  } ->
  teerex::checkout { 'design_loader':
    checkout_project => $design_loader_checkout,
    release_tag => $design_loader_tag,
  } ->
  teerex::checkout { 'print_genie':
    checkout_project => $print_genie_checkout,
    release_tag => $print_genie_tag,
  } ->
  file { "${suite_dir}":
    ensure => 'directory',
  } ->
  file { "${suite_dir}\\logs":
    ensure => 'directory',
    mode => '0777',
    group => 'Administrators',
  } ->
  file { "${suite_dir}\\Designs":
    ensure => 'directory',
    mode => '0777',
    group => 'Administrators',
  } ->
  file { "${suite_dir}\\Designs_ARX4":
    ensure => 'directory',
    mode => '0777',
    group => 'Administrators',
  } ->
  exec { 'run_script':
    command => "${home_dir}\\${design_loader_checkout}\\Design_Loader\\Design_Loader.exe",
  }

  scheduled_task { 'run_design_loader_hourly':
    ensure    => present,
    enabled   => true,
    working_dir  => $puppet_dir,
    command   => "${puppet_dir}\\puppet.bat",
    compatibility => 2,
    arguments => "apply --modulepath=${home_dir}\\${puppet_checkout}\\puppet\\modules;${home_dir}\\PuppetLabs\\code\\modules --logdest=\"${suite_dir}\\logs\\puppet_logs.txt\" ${home_dir}\\${puppet_checkout}\\puppet\\manifests\\site.pp",
    trigger   => {
      schedule         => daily,
      start_time       => '00:00',
      minutes_interval => '10',
      minutes_duration => '1440',
    }
  }
}

