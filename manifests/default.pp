exec { "apt-get update":
  command => "/usr/bin/apt-get update",
  refreshonly => true,
}
exec { "apt-get upgrade":
  command => "/usr/bin/apt-get upgrade",
  require => Exec["apt-get update"],
}
package { "apache2":
  ensure  => present,
  require => Exec["apt-get upgrade"],
}
service { "apache2":
  ensure  => "running",
  require => Package["apache2"],
}
file { "/var/www/sample-webapp":
  ensure  => "link",
  target  => "/vagrant/sample-webapp",
  require => Package["apache2"],
  notify  => Service["apache2"],
}
