To run Puppet:
1) Install Puppet. Download puppet agent from http://downloads.puppetlabs.com/windows/puppet6/
2) Install windows_env module
   cmd: "puppet module install --target-dir=C:\ProgramData\PuppetLabs\code\modules puppet/windows_env"
3) Clone teerex-puppet repo:
   cmd: "git clone https://github.com/hotelCA/teerex-puppet.git"
4) Run puppet the first time. "cd" to the teerex-puppet directory, then run:
   cmd: "puppet apply --modulepath=.\puppet\modules;C:\ProgramData\PuppetLabs\code\modules .\puppet\manifests\site.pp"