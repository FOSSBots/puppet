# This function is the standard way to combine multiple URLs into one string
# suitable for passing to Icinga as the $notes_url arg of an underlying Icinga
# resource (for instance monitoring::check_prometheus or nrpe::monitor_service).
#
# In general, users of those resources do not need to worry about this; it's
# for internal implementations of monitoring resources.
function monitoring::build_notes_url(
    Optional[Stdlib::HTTPSUrl] $notes_link,
    Array[Stdlib::HTTPSUrl,0,4] $dashboard_links) >> String
{
    $link_fail_message = 'The $dashboard_links and $notes_links URLs must not be URL-encoded'
    # The notes link always has to come first to ensure the correct icon is used in icinga
    # we start with `[]` so puppet knows we want a array
    if $notes_link {
        $links = [] + $notes_link + $dashboard_links
    } else {
        $links = [] + $dashboard_links
    }

    $notes_urls = $links.reduce('') |$urls, $link| {
        if $link =~ /%\h\h/ {
            fail($link_fail_message)
        }
        "${urls}'${link}' "
    }.strip
    # Backwards compatibility
    # Split on space and if we have only 1 element, then remove the single
    # quotes
    $ar = split($notes_urls, ' ')
    if size($ar) == 1 {
        $result = regsubst($ar[0], '\'', '', 'G')
    } else {
        $notes_urls
    }
}
