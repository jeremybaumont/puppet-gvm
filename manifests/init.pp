# This is a placeholder class.
class gvm(
  $version = $gvm::params::version
) inherits gvm::params {

  # get the download URI
  $download_uri = "https://raw.githubusercontent.com/moovweb/gvm/${version}/binscripts/gvm-installer"

  $install_command = "bash <(curl -s -S -L ${download_uri})"

  exec {
    "install gvm ${version}":
      command => $install_command,
      unless  => "test -x ~/.gvm && gvm version| grep '\\b${version}\\b'",
      }
}
