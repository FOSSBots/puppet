define monitoring::service(
    Optional[String] $description,
    String $check_command,
    String $notes_url,
    Variant[Stdlib::Host,String] $host = $::hostname,
    Integer $retries        = 3,
    Optional[String] $group = undef,
    Wmflib::Ensure $ensure  = present,
    Boolean $critical       = false,
    Boolean $passive        = false,
    Integer $freshness      = 36000,
    Integer $check_interval = 1,
    Integer $retry_interval = 1,
    String $contact_group   = lookup('contactgroups', {'default_value' => 'admins'}), # FIXME, defines should not have calls to hiera/lookup
    Stdlib::Unixpath $config_dir = '/etc/nagios',
    Optional[Variant[Boolean,String]] $event_handler = undef,
    Optional[Variant[Integer[0, 1],Boolean,String]] $notifications_enabled = $::profile::base::notifications_enabled, # FIXME, base modules should not reference variables in the profile name space
){

    # the list of characters is the default for illegal_object_name_chars
    # nagios/icinga option
    if $description {
        $description_safe = regsubst($description, '[`~!$%^&*"|\'<>?,()=]', '-', 'G')
    } else {
        $description_safe = ''
    }

    if $check_command =~ /\\n/ {
        fail("Parameter check_command cannot contain newlines: ${check_command}")
    }

    if ! $host {
        fail("Parameter ${host} not defined!")
    }

    $cluster_name = lookup('cluster')

    $servicegroups = $group ? {
        /.+/    => $group,
        default => lookup('nagios_group', {'default_value' => "${cluster_name}_${::site}"}),
    }

    $notification_interval = $critical ? {
        true    => 240,
        default => 0,
    }

    # If a service is set to critical and
    # paging is not disabled for this machine in hiera,
    # then use the "sms" contact group which creates pages.
    $do_paging = lookup('do_paging', {'default_value' => true})

    case $critical {
        true: {
            case $do_paging {
                true:    {
                  $real_contact_groups = "${contact_group},sms,admins"
                  $real_description = "${description_safe} #page"
                }
                default: {
                  $real_contact_groups = "${contact_group},admins"
                  $real_description = $description_safe
                }
            }
        }
        default: {
          $real_contact_groups = $contact_group
          $real_description = $description_safe
        }
    }

    $is_active = $passive ? {
        true    => 0,
        default => 1,
    }

    $check_volatile = $passive ? {
        true    => 1,
        default => 0,
    }

    $check_fresh = $passive ? {
        true    => 1,
        default => 0,
    }

    $is_fresh = $passive ? {
        true    => $freshness,
        default => undef,
    }

    # Safeguard against notifications enabled not being defined due to class
    # declarations
    if $notifications_enabled {
        $real_notifications_enabled = $notifications_enabled
    } else {
        $real_notifications_enabled = '1'
    }

    # the nagios service instance
    $service = {
        "${::hostname} ${title}" => {
            ensure                 => $ensure,
            host_name              => $host,
            servicegroups          => $servicegroups,
            service_description    => $real_description,
            check_command          => $check_command,
            max_check_attempts     => $retries,
            check_interval         => $check_interval,
            retry_interval         => $retry_interval,
            check_period           => '24x7',
            notification_interval  => $notification_interval,
            notification_period    => '24x7',
            notification_options   => 'c,r,f',
            notifications_enabled  => $real_notifications_enabled,
            contact_groups         => $real_contact_groups,
            passive_checks_enabled => 1,
            active_checks_enabled  => $is_active,
            is_volatile            => $check_volatile,
            check_freshness        => $check_fresh,
            freshness_threshold    => $is_fresh,
            event_handler          => $event_handler,
            notes_url              => $notes_url,
        },
    }
    # This is a hack. We detect if we are running on the scope of an icinga
    # host and avoid exporting the resource if yes
    if defined(Class['icinga']) {
        create_resources(nagios_service, $service)
    } else {
        create_resources('monitoring::exported_nagios_service', $service)
    }
}
