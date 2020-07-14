class role::bots {	
    system::role { 'Bots Server': description => 'Role for bots*' }	
    include ::profile:web	
}
