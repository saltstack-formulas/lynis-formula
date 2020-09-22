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
