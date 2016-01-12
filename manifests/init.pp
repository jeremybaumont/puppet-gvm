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

      if $::operatingsystem == 'Darwin' {
        include boxen::config

        boxen::env_script { 'packer':
          content  => template('packer/env.sh.erb'),
          priority => 'lower',
        }

        file { "${boxen::config::envdir}/packer.sh":
          ensure => absent,
        }
      }
    }

    absent: {
      file { $root:
        ensure  => absent,
        recurse => true,
        force   => true,
      }
    }

    default: {
      fail('Ensure must be present or absent')
    }
  }

}
