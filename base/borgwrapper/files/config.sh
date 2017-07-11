{{ salt['pillar.get']('salt:managed_file_header', '# This file is managed by Salt') }}

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
{%- if config.pre_backup_cmd is defined %}
PRE_BACKUP_CMD=({{ config.pre_backup_cmd }})
{%- endif %}
{%- if config.post_backup_cmd is defined %}
POST_BACKUP_CMD=({{ config.post_backup_cmd }})
{%- endif %}
{%- if config.post_verify_cmd is defined %}
POST_VERIFY_CMD=({{ config.post_verify_cmd }})
{%- endif %}
{%- if config.bwlimit is defined %}
BWLIMIT={{ config.bwlimit }}
{%- endif %}
