#!/sbin/openrc
# Modified version of the redmine 2.4.6 initscript from the official repository.

RAILS_ENV=${RAILS_ENV:-production}
REDMINE_DIR=${REDMINE_DIR:-/usr/local/lib/redmine}
REDMINE_ADDRESS=${REDMINE_ADDRESS:-localhost}
REDMINE_PORT=${REDMINE_PORT:-3000}
REDMINE_USER=${REDMINE_USER:-redmine}
REDMINE_GROUP=${REDMINE_GROUP:-redmine}
REDMINE_PIDFILE="/var/run/redmine/server.pid"

depend() {
    use mysql net
}

start_pre() {
    if [ ! -e "${REDMINE_DIR}/config/initializers/secret_token.rb" ] ; then
        eerror "Initialize secret token:"
        eerror
        eerror "bundle exec rake generate_secret_token"
        eerror
        return 1
    fi
    if [ ! -d /var/run/redmine ]; then
        checkpath -q -d -m 0755 -o redmine:redmine /var/run/redmine
    fi
}

start() {
    ebegin "Starting redmine"
    cd "${REDMINE_DIR}"
    start-stop-daemon --start --quiet --user ${REDMINE_USER}:${REDMINE_GROUP} \
        --pidfile "${REDMINE_PIDFILE}" \
        --exec /usr/bin/ruby "${REDMINE_DIR}"/bin/rails server -- \
        --daemon --environment=${RAILS_ENV} \
        --binding=${REDMINE_ADDRESS} --port=${REDMINE_PORT} \
        --pid="${REDMINE_PIDFILE}" \
        ${REDMINE_OPTS}
    eend $?
}

stop() {
    ebegin "Stopping redmine"
    cd "${REDMINE_DIR}"
    start-stop-daemon --signal INT --quiet --pidfile "${REDMINE_PIDFILE}"