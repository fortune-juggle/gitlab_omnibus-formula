======
Gitlab Omnibus
======

Formulas for working with Gitlab Omnibus

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``gitlab_omnibus``
----------

Install and run Gitlab Omnibus System


# Test local

### Requirements
* Docker
* Ruby eg with
```asdf-vm```

```
cd <formula dir>
bundle install
```

Run a converge on the default configuration:
```
kitchen converge
```
Run a verify on the default configuration:
```
kitchen verify
```