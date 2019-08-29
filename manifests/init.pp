# @summary 
#    Ensure mail transfer agent is configured for local-only mode (Scored)
#
# Mail Transfer Agents (MTA), such as sendmail and Postfix, are used to listen for incoming mail and transfer 
# the messages to the appropriate user or mail server. If the system is not intended to be a mail server, it 
# is recommended that the MTA be configured to only process local mail.
#
# Rationale:
# The software for all Mail Transfer Agents is complex and most have a long history of security issues. While it 
# is important to ensure that the system can process local mail messages, it is not necessary to have the MTAs 
# daemon listening on a port unless the server is intended to be a mail server that receives and processes 
# mail from other systems.
#
# @param enforce
#    Enforce the rule or just test and log
#
# @param message
#    Message to print into the log
#
# @param loglevel
#    The loglevel for the above message
#
# @param config_data
#    Hash with additional configuration data
#
# @example
#   class security_baseline_postfix {
#       enforce => true,
#       message => 'Test',
#       loglevel => 'info',
#       config_data => {
#         inet_interfaces => 'loopback-only',  
#       }
#   }
#
class security_baseline_postfix (
  Boolean $enforce = true,
  String $message = '',
  String $loglevel = '',
  Optional[Hash] $config_data = {}
) {
  if($config_data) {
    validate_hash($config_data)
  }

  if $enforce {

    if(has_key($config_data, 'inet_interfaces')) {

      $ifaces = $config_data['inet_interfaces']

      class { '::postfix':
        inet_interfaces => 'loopback-only',
      }
    }

  } else {

    if($::srv_mta) {

      notify { 'postfix':
        message  => $message,
        loglevel => $loglevel,
      }
    }
  }
}
