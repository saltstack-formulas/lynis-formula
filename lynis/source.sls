# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "lynis/map.jinja" import lynis with context %}

install_lynis:
  git.latest:
    - name: {{ lynis.git_url }}
    - target: '/usr/local/lynis'
