define teerex::checkout (
  $checkout_project,
  $release_tag = undef)
  {
  $home_dir = $facts['windows_env']['PROGRAMDATA']
  $checkout_dir = "${home_dir}\\${checkout_project}"
  $git_dir = 'C:\\Program Files\\Git\\bin'

  exec { "clone_${name}":
    path    => $git_dir,
    cwd     => $home_dir,
    command => "git clone https://github.com/hotelCA/${checkout_project}.git",
    unless  => "C:\\Windows\\System32\\cmd.exe /c dir ${checkout_dir}"
  }

  if $release_tag == undef {
    exec { "update_checkout_${name}":
      path    => $git_dir,
      cwd     => $checkout_dir,
      command => 'git pull',
      require => Exec["clone_${name}"],
    }
  } else {
    exec { "fetch_tags_${name}":
      path    => $git_dir,
      cwd     => $checkout_dir,
      command => 'git fetch --all --tags',
      require => Exec["clone_${name}"],
    } ->
    exec { "checkout_tag_${name}":
      path    => $git_dir,
      cwd     => $checkout_dir,
      command => "git checkout tags/${release_tag}",
    }
  }
}

