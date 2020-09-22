# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "lynis/map.jinja" import lynis with context %}

include:
{% if lynis.install_from_source %}
  - .source
{% elif lynis.install_from_package %}
  - .package
{% endif %}
  - .config
