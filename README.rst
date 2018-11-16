
==================================
Ulogd Formula
==================================

Ulogd2 is a userspace logging daemon for netfilter/iptables related logging.


Sample Metadata
===============

Single ulogd service

.. code-block:: yaml

    ulogd:
      server:
        enabled: true
        sections: |            # If no "sections" are defined - default config (/etc/ulogd.conf) is used
          [global]
          logfile="syslog"
          loglevel=3
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_inppkt_NFLOG.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_inpflow_NFCT.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_filter_IFINDEX.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_filter_IP2STR.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_filter_IP2BIN.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_filter_PRINTPKT.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_filter_HWHDR.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_filter_PRINTFLOW.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_output_LOGEMU.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_output_SYSLOG.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_output_XML.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_output_GPRINT.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_raw2packet_BASE.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_inpflow_NFACCT.so"
          plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_output_GRAPHITE.so"
          stack="ct1:NFCT,ip2str1:IP2STR,print1:PRINTFLOW,sys2:SYSLOG"

          [ct1]
          hash_enable=0
          event_mask=0x00000001

          [sys2]
          facility=LOG_LOCAL2

    ...
    ...
    linux:
      system:
        kernel:
          sysctl:
            net.netfilter.nf_conntrack_acct: 1
            net.netfilter.nf_conntrack_timestamp: 1
    ...
    ...
    rsyslog:
      client:
        enabled: true
        output:
          file:
            /var/log/ulog/ulogd.log:
              filter: local2.*
              owner: syslog
              group: adm
              createmode: 640
              umask: 0022
              sync: false
              enabled: true
          remote:
            192.168.1.1:
              action: "@@192.168.1.1:514"
              filter: "local2.*"
              enabled: true
    ...
    ...
    logrotate:
      server:
        enabled: true
        job:
          ulogd2:
            - files:
              - /var/log/ulog/ulogd.log
              options:
                - rotate: 30
                - daily
                - missingok
                - compress
                - sharedscripts
                - create 640 ulog adm
                - postrotate: "invoke-rc.d ulogd2 reload > /dev/null"


References
==========

* https://netfilter.org/documentation/index.html
* https://netfilter.org/projects/ulogd/
* https://git.netfilter.org/ulogd2/


Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use GitHub issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-ulogd/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

You should also subscribe to mailing list (salt-formulas@freelists.org):

    https://www.freelists.org/list/salt-formulas

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
