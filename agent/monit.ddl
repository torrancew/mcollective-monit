metadata :name        => 'Monit Agent',
         :description => 'Monit interaction for MCollective',
         :url         => 'https://github.com/torrancew/mcollective-monit',
         :author      => 'Tray Torrance',
         :license     => 'GPLv2',
         :version     => '0.1',
         :timeout     => 5

action 'monitor', :description => 'Enable monitoring of a specific service' do
  input :name,
        :prompt      => 'Monit Resource Name',
        :description => 'Monit resource to enable monitoring on',
        :type        => :string,
        :validation  => '^[A-Za-z0-9_-]+$',
        :optional    => false,
        :maxlength   => 50

#  output :output,
#         :description => 'Output from the monitor action',
#         :display_as  => 'Output'

  output :exitcode,
    :description => 'Exit code from the monitor action',
    :display_as  => 'Exit Code'
end
