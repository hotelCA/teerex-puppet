define teerex::checkout (
  $checkout_project,
  $release_tag = undef)
  {
  $home_dir = $facts['windows_env']['ALLUSERSPROFILE']
  $checkout_dir = "${home_dir}\\${checkout_project}"
  $git_dir = 'C:\\Program Files\\Git\\bin'

  if $release_tag == undef {
    exec { "update_checkout_${name}":
      path    => $git_dir,
      cwd     => $checkout_dir,
      command => 'git pull',
    }
  } else {
    exec { "fetch_tags_${name}":
      path    => $git_dir,
      cwd     => $checkout_dir,
      command => 'git fetch --all --tags',
    } ->
    exec { "checkout_tag_${name}":
      path    => $git_dir,
      cwd     => $checkout_dir,
      command => "git checkout tags/${release_tag}",
    }
  }
}

