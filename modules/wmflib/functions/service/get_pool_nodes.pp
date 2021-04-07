function wmflib::service::get_pool_nodes(String $pool) >> Array[String] {
    # TODO: this is a bit hard-coded
    $module_path = get_module_path('wmflib')
    $site_nodes = loadyaml("${module_path}/../../conftool-data/node/${::site}.yaml")[$::site]
    $pool_data = wmflib::service::fetch(true)[$pool]
    if $pool_data == undef {
        fail("Could not find a definition for pool '${pool}'")
    }
    $conftool_cluster = $pool_data['lvs']['conftool']['cluster']
    $conftool_service = $pool_data['lvs']['conftool']['service']
    $cluster_nodes = $site_nodes[$conftool_cluster]
    if $cluster_nodes == undef {
        fail("Could not find the conftool cluster '${cluster}' in site '${::site}' (pool '${pool}')")
    }
    $cluster_nodes.map |$node, $services| {
        if $conftool_service in $services {
            $node
        }
        else {
            undef
        }
    }
    .filter |$node| {
        $node != undef
    }
}
