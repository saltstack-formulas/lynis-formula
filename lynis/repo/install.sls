# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import lynis with context %}

lynis/repo/install:
  pkgrepo.managed:
    - humanname: Lynis
    {% if salt['grains.get']('os_family') == 'Debian' %}
    {% if lynis.repo.use_customers_repo and lynis.repo.license_key %}
    - name: deb [arch=amd64] https://packages.cisofy.com/customers/{{ lynis.repo.license_key }}/lynis/deb/ {{ salt['grains.get']('oscodename') }} main
    {% else %}
    - name: deb [arch=amd64] https://packages.cisofy.com/community/lynis/deb/ {{ salt['grains.get']('oscodename') }} main
    {% endif %}
    - file: /etc/apt/sources.list.d/lynis.list
    - key_url: {{ lynis.repo.key_url }}
    {% elif salt['grains.get']('os_family') == 'RedHat' %}
    {# TODO: add RHEL/CentOS support #}
    {% endif %}
