class teerex::common {
  $home_dir = $facts['windows_env']['ALLUSERSPROFILE']
  $binary_dir = "${home_dir}\\teerex-puppet"
  $suite_dir = "${home_dir}\\Genie Suite"
  $program_files_dir = "C:\\Program Files"
  $puppet_dir = "${program_files_dir}\\Puppet Labs\\Puppet\\bin"
  $git_dir = 'C:\\Program Files\\Git\\bin'

  exec { 'update_checkout':
    path    => $git_dir,
    cwd     => $binary_dir,
    command => 'git pull',
  } ->
  file { "${suite_dir}":
    ensure => 'directory',
  } ->
  file { "${suite_dir}\\logs":
    ensure => 'directory',
  } ->
  file { "${suite_dir}\\Designs":
    ensure => 'directory',
  } ->
  file { "${suite_dir}\\Designs_ARX4":
    ensure => 'directory',
  } ->
  exec { 'run_script':
    command => "${binary_dir}\\Design_Loader\\Design_Loader.exe",
  }

  scheduled_task { 'run_design_loader_hourly':
    ensure    => present,
    enabled   => true,
    working_dir  => $puppet_dir,
    command   => "${puppet_dir}\\puppet.bat",
    compatibility => 2,
    arguments => "apply --modulepath=${binary_dir}\\puppet\\modules;${home_dir}\\PuppetLabs\\code\\modules --logdest=\"${suite_dir}\\logs\\puppet_logs.txt\" ${binary_dir}\\puppet\\manifests\\site.pp",
    trigger   => {
      schedule         => daily,
      start_time       => '00:00',
      minutes_interval => '30',
      minutes_duration => '1440',
    }
  }
}

