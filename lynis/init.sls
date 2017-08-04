# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "lynis/map.jinja" import lynis with context %}

include:
{% if lynis.install_from_source %}
  - lynis.source
{% elif lynis.install_from_package %}
  - lynis.install
{% endif %}
