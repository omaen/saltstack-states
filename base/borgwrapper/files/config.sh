#
# This file is managed by Salt. Changes will be overwritten
#

BORG="{{ config.borg }}"
BORG_REPO="{{ config.repo }}"
BORG_PASSPHRASE="{{ config.passphrase }}"
PATHS=(
{%- for path in config.paths %}
    "{{ path }}"
{%- endfor %}
)
EXCLUDES=(
{%- for exclude in config.excludes %}
    "{{ exclude }}"
{%- endfor %}
)
KEEP_DAILY={{ config.keep_daily }}
KEEP_WEEKLY={{ config.keep_weekly }}
KEEP_MONTHLY={{ config.keep_monthly }}
KEEP_YEARLY={{ config.keep_yearly }}
{%- if config.bwlimit is defined %}
BWLIMIT={{ config.bwlimit }}
{%- endif %}
{%- if config.use_nice is defined %}
USE_NICE={{ config.use_nice }}
{%- endif %}
{%- if config.nice is defined %}
NICE={{ config.nice }}
{%- endif %}
