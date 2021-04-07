# This function returns the url for a service, supporting the use of the services proxy too.
# Parameters:
#
# [*svc_name*]
#   The service name, as found in the service::catalog hiera variable or in the listeners list
#
# [*url*]
#   The url path relative to the server name. Defaults to the empty string
#
# [*listeners*]
#   An optional array of service proxy listeners. If provided, the url will be
#   pointed to the service proxy instead than directly to the load balancer.
#
# [*site*]
#   If set to 'discovery', the discovery service URL will be returned,
#   e.g. $svc_name.discovery.wmnet. Else, a site (datacenter) specific url will
#   be returned, e.g. $svc_name.svc.$site.wmnet.  The site specific URL is
#   obatined from the service catalog entry's monitoring configuration.
#   This parameter is ignored if $listeners is set.
#   Default: 'discovery'.
#
function wmflib::service::get_url(
    String $svc_name,
    String $url = '',
    Optional[Array[Hash]] $listeners = undef,
    String $site = 'discovery',
) >> String {
    # We are using the service directly, no proxy
    if $listeners == undef {
        # service::catalog should contain $svc_name.
        $service = wmflib::service::fetch()[$svc_name]
        if $service == undef {
            fail("Service ${svc_name} not found in the catalog.")
        }

        if $site == 'discovery' {
            if $service['discovery'] == undef {
                fail("Service ${svc_name} doesn't have a discovery record!")
            }
            $dns_label = $service['discovery'][0]['dnsdisc']
            $host = "${dns_label}.discovery.wmnet"
        } else {
            if !($site in $service['sites']) {
                fail("Service ${svc_name} is not present in site ${site}.")
            }
            if (
                $service['monitoring'] == undef or
                $service['monitoring']['sites'] == undef or
                $service['monitoring']['sites'][$site] == undef or
                $service['monitoring']['sites'][$site]['hostname'] == undef
            ) {
                fail("Service ${svc_name} does not have monitoring for site ${site} configured; cannot determine site specific hostname.")
            }
            $host = $service['monitoring']['sites'][$site]['hostname']
        }

        $port = $service['port']
        $scheme = $service['encryption'] ? {
            true    => 'https',
            default => 'http'
        }
    } else {
        # We use the service proxy.
        $host = 'localhost'
        $related = $listeners.filter |$l| { $l['name'] == $svc_name }
        if $related.length() != 1 {
            fail("One and only one listener with name '${svc_name}' is expected")
        }
        $port = $related[0]['port']
        $scheme = 'http'
    }
    "${scheme}://${host}:${port}${url}"
}
