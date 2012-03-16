module MCollective
  module Agent
    class Monit < RPC::Agent
      metadata :name        => 'Monit Agent',
               :description => 'Monit interaction for MCollective',
               :url         => 'https://github.com/torrancew/mcollective-monit',
               :author      => 'Tray Torrance',
               :license     => 'GPLv2',
               :version     => '0.1',
               :timeout     => 5

      action 'monitor' do
        validate :name, :shellsafe

        command          = "/usr/bin/monit monitor #{request.data[:name]}"
        reply[:exitcode] = run(command)

        case reply[:exitcode]
        when 0
          reply.statusmsg
        else
          reply.fail "ERROR: #{command}"
        end
      end
    end
  end
end
