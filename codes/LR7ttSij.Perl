# file Errors.pm

package API::Model::Errors;
use Mojo::Base 'MojoX::Model';
use Moo;

# attribute errors
has 'errors' => (
    is => 'ro',
    default => sub {
        []
    }
);

# method set error
sub setError {
    my ($self, $error) = @_;
    
    push(@{$self->errors}, $error);
}

# method get errors
sub getErrors {
    my $self = shift;
    
    my $result = {};
    $result->{success} = 0;
    $result->{errors} = $self->errors;
    
    return $result;
}

# method get total errors
sub totalErrors {
    my $self = shift;
    
    return scalar(@{$self->errors});
}

1;

# file Settings.pm

package API::Model::Settings;
use Mojo::Base 'MojoX::Model';
use Moo;
extends qw/API::Model::Errors/;

sub passwordChange {
    my ($self, $password_current, $password_new) = @_;
    
    # get password in database and valid
    $self->setError('Password current incorrect!') unless $self->app->model('users-read')->validIdAndPassword($self->app->usr_id, $password_current);
    
    # if have some problem, return error
    return $self->getErrors if $self->totalErrors;
    
    # update password in database
    $self->app->model('users-update')->passwordChange($self->app->usr_id, $password_new);
    
    # return successes
    return $self->getSuccesses;
}

1;

# Action in Controller

sub password_change {
    my $self = shift;
    
    # params
    my $password_current = $self->param('password_current') || '';
    my $password_new = $self->param('password_new') || '';
    my $password_new2 = $self->param('password_new2') || '';
    
    # valid params
    my $errors = $self->model('errors')->new;
    $errors->setError('Password current invalid!') unless $password_current && $password_current =~ /^\w+$/;
    $errors->setError('Password new invalid!') unless $password_new && $password_new =~ /^\w+$/;
    $errors->setError('Password new 2 invalid!') unless $password_new2 && $password_new2 =~ /^\w+$/;
    $errors->setError('Password new and Password new 2 are different!') unless $password_new =~ /^${password_new2}$/;
    
    # first test if have errors with ternary operator, if true run method, if false get errors
    my $result = $errors->totalErrors == 0
    ? $self->model('settings')->passwordChange($password_current, $password_new)
    : $errors->getErrors;
    
    # print json
    $self->render(
        json => $result
    );    
}