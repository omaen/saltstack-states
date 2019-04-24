# My collection of saltstack states
## How to use
* Fork this repo and update it once in a while while inspecting the changes to have total control of changes in your own system. The repo is made for my own usage so breaking changes may occur, and states may even be removed, although both happens rarely.
* Include this directory in your master config
* I prefer to create another folder called `local-states` for my top.sls and system specific states

## Easy bootstrap
* https://github.com/saltstack/salt-bootstrap

## In addition to these I often use these official salt formulas
* https://github.com/saltstack-formulas/salt-formula
* https://github.com/saltstack-formulas/nginx-formula
* https://github.com/saltstack-formulas/postgres-formula
