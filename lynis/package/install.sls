# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_repo_file = tplroot ~ '.repo.install' %}
{%- from tplroot ~ "/map.jinja" import lynis with context %}

{% if lynis.use_repo %}
include:
  - {{ sls_repo_file }}
{% endif %}

{%- if salt['grains.get']('osfinger', '') in ['Amazon Linux-2'] %}
lynis/package/pkgrepo/epel:
  pkgrepo.managed:
    - name: epel
    - humanname: Extra Packages for Enterprise Linux 7 - $basearch
    - mirrorlist: https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
    - failovermethod: priority
    - require_in:
      - pkg: lynis/package/install
{%- endif %}

lynis/package/install:
  {#- If portage config is provided for Gentoo, construct the `portage_config.flags` state
      by performing the union of the `base_state` and the config provided via. the map #}
  {%- if grains.os_family == 'Gentoo' and lynis.get('portage_config_flags', []) %}
  {%-   load_yaml as base_state %}
  portage_config_flags:
    - name: {{ lynis.package }}
    - require_in:
      - pkg: lynis/package/install
  {%-   endload %}
  {%-   set state_portage_config_flags = base_state.portage_config_flags | union(lynis.portage_config_flags) %}
  {%-   do salt["log.debug"](
          "Rendered state (union of `base_state` and config provided via. the map)\n  portage_config.flags:\n"
          ~ state_portage_config_flags | yaml(False) | indent(4, True)
        ) %}
  portage_config.flags: {{ state_portage_config_flags }}
  {%- endif %}

  pkg.installed:
    - pkgs:
      - {{ lynis.package }}
      {% if lynis.install_plugins %}
      - lynis-plugins
      {% endif %}
    {% if lynis.use_repo %}
    - refresh: true
    - require:
      - sls: {{ sls_repo_file }}
    {% endif %}
