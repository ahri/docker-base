/bin/sh
set -ue

mv /etc/service/syslog-ng/run /tmp/syslog-ng_run
cat - /tmp/syslog-ng_run <<NEW_START > /etc/service/syslog-ng/run && chmod 755 /etc/service/syslog-ng/run
#!/bin/sh
set -ex
if [ ! -z "\$LOGGLY_CUSTOMER_TOKEN" ] && [ ! -z "\$LOGGLY_TAG" ] && [ ! -f /etc/syslog-ng/conf.d/loggly.conf ]; then
sed -i 's/internal()/#internal()/' /etc/syslog-ng/syslog-ng.conf

cat <<LOGGLY_CONF | sed "s/TOKEN/\$LOGGLY_CUSTOMER_TOKEN/;s/TAG/\$LOGGLY_TAG/" > /etc/syslog-ng/conf.d/loggly.conf
### Syslog-ng Logging Directives for Loggly.com ###
source s_loggly {
    #system();  # Check which OS & collect system logs
    internal(); # Collect syslog-ng logs
};

template LogglyFormat { template("<\\\${PRI}>1 \\\${ISODATE} \\\${HOST} \\\${PROGRAM} \\\${PID} \\\${MSGID} [TOKEN@41058 tag=\"TAG\"] \\\$MSG\n");
    template_escape(no);
};

destination d_loggly {
    tcp("logs-01.loggly.com" port(514) template(LogglyFormat));
};

log { 
    source(s_loggly); 
    destination(d_loggly); 
};
### END Syslog-ng Logging Directives for Loggly.com ###
LOGGLY_CONF
fi

NEW_START
