class role::acme_chief::cloud {
    system::role { 'Bots Server': description => 'Role for bots*' }
    include ::profile:web
}
