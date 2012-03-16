class MCollective::Application::Monit < MCollective::Application
  description "Enable the monitoring of specific services via Monit"
  usage <<-END_OF_USAGE
  mco monit [OPTIONS] [FILTERS] <ACTION> [ARGUMENTS]

  The ACTION can be one of the following:
    monitor - Enable the monitoring of <NAME> with monit

  EXAMPLES:
    mco monit monitor -n nrpe
END_OF_USAGE

  option :name,
         :description => "Name of the service to monitor",
         :arguments   => ['--name NAME', '-n NAME'],
         :type        => String,
         :required    => false

  def post_option_parser(configuration)
    if ARGV.length >= 1
      configuration[:command] = ARGV.shift
      unless configuration[:command].match(/^(monitor)$/)
        raise "Action must be monitor"
      end
    else
      raise "Please specify an action"
    end
  end

  def main
    mc          = rpcclient('monit')
    mc.progress = true

    case configuration[:command]
    when 'monitor'
      puts "Discovering hosts to run"
      mc.discover
      puts "Enabling #{configuration[:name]}"
      printrpc mc.monitor(:name => configuration[:name], :options => options)
    else
    end
    mc.disconnect
    printrpcstats
  end

end
