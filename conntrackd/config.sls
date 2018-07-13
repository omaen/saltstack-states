{% from 'conntrackd/map.jinja' import conntrackd with context %}

conntrackd_conf:
  file.managed:
    - name: {{ conntrackd.config_file }}
    - source: salt://conntrackd/files/conntrackd.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - context:
        # Filter via json for sane ordering, mainly to avoid the error
        # "NetlinkBufferSize is either not set or is greater than NetlinkBufferSizeMaxGrowth" when
        # conntrackd starts if "NetlinkBufferSize" is defined before the increased "NetlinkBufferSizeMaxGrowth"
        # limit is configured in the config file
        config: {{ conntrackd.config|json }}
    - watch_in:
      - service: {{ conntrackd.service }}
