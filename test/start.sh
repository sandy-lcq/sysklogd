#!/bin/sh
. ./test.rc

if [ x"${srcdir}" = x ]; then
    srcdir=.
fi

mkdir -p ${CONFD}
cat <<EOF > ${CONF}
# Nothing here yo
include ${CONFD}/*.conf
EOF

cat <<EOF > ${CONFD}/foo.conf
# Local log file, avoid sync to disk
*.*	-${LOG}
EOF

cat <<EOF > ${CONFD}/bar.conf
# For remote logging
*.*	@127.0.0.2
EOF

../src/syslogd -b :${PORT} -d -n -f ${CONF} -p ${SOCK} &
echo "$!" > ${PID}

sleep 1