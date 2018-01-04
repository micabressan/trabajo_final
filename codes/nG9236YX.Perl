package Dancer::Plugin::DebugDbicQueryLog;

use Dancer ':syntax';
use Dancer::Plugin;
use Dancer::Plugin::DBIC;

hook before => sub {
    return unless config->{plugins}{DBIC}{QueryLog};
    my $querylog = request->env->{'plack.middleware.dbic.querylog'};

    foreach my $schema_name (keys %{ config->{plugins}{DBIC} } ) {
        my $schema = schema($schema_name);
        $schema->storage->debug(1);
        $schema->storage->debugobj($querylog);
    }
};

register_plugin;

1;