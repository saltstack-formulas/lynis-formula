# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import lynis with context %}

lynis/source/install:
  git.latest:
    - name: {{ lynis.git_url }}
    - target: '/usr/local/lynis'
