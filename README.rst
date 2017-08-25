================
lynis-formula
================

A saltstack formula that is used to install the latest version of `Lynis <https://cisofy.com/documentation/lynis/>`_.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``lynis``
------------

Meta state to installs Lynis.

``lynis.install``
-----------------

Install lynis from package

``lynis.source``
----------------

Installs the latest version of Lynis from it's git repository.

``lynis.repo``
--------------

Creates the repo file to install lynis from upstream repository.
