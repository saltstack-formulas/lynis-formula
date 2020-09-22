# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import lynis with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
{%- set config_dir = lynis.config_dir %}

include:
  - {{ sls_package_install }}

{%- for profile_name, config in lynis.config.profiles.items() %}
lynis/config/install/profile/{{ profile_name }}:
  file.managed:
    - name: {{ config_dir }}/{{ profile_name }}.prf
    - source: {{ files_switch(['profile.tmpl.jinja'],
                              lookup='lynis/config/install/profile/' ~ profile_name
                 )
              }}
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: true
    - require:
      - sls: {{ sls_package_install }}
    - context:
        config: {{ config | json }}

{%- endfor %}
