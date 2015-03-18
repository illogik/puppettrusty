exec { "apt-get update":
  path => "/usr/bin",
}
exec { "apt-get upgrade":
  path => "/usr/bin",
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
