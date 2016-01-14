# This is a placeholder class.
class gvm(
  $version = $gvm::params::version
) inherits gvm::params {
  
  case $ensure {
    present: {
      # get the download URI
      $download_uri = "https://raw.githubusercontent.com/moovweb/gvm/${version}/binscripts/gvm-installer"

      $install_command = join([
        "bash <<(curl -s -S -L ${download_uri})"
      ], ' && ')

      exec {
        "install gvm v${version}":
          command => $install_command,
          #unless  => "test -x ~/.gvm && gvm version| grep '\\bv${version}\\b'",
      }
    }

    absent: {
      file { $root:
        ensure  => absent,
        recurse => true,
        force   => true,
      }
    }

  }

}
