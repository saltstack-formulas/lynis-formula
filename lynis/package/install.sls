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
  pkg.installed:
    - pkgs:
      - lynis
      {% if lynis.install_plugins %}
      - lynis-plugins
      {% endif %}
    {% if lynis.use_repo %}
    - refresh: true
    - require:
      - sls: {{ sls_repo_file }}
    {% endif %}
