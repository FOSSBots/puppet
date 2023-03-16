node /^bots[3]001\.fossbots\.org$/ {
  include role::botserver
}
node /^tools[3]001\.fossbots\.org$/ {
  include role::toolserver
  include ::icinga2::node
}
node /^db[3]001\.fossbots\.org$/ {
  include role::dbserver
}

