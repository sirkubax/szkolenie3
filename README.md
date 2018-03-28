Getting Started
===============


System Prerequisites
--------------------

`$ sudo apt-get install python-virtualenv libpq-dev python-all-dev libffi-dev`

The `python-virtualenv` system package provides, unsurprisingly, the Python
`virtualenv` package. It is used to isolate groups of third-party libraries and
allows for multiple Python projects with conflicting dependencies to be
developed in parallel. `libpq-dev` is important for some sub-package compilation.
`python-all-dev` provides some Python.h headers. `libffi-dev` needed for cryptography. 


Prepare Environment
-------------------

`$ source environment.sh`

This will set some environment variables, create and activate a Python
virtualenv and install the dependencies found in `requirements.txt`. Activating
the virtualenv changes where your shell locates the `python` and `pip`
executables and changes where Python locates installed packages. You can see
how all of this is works by examining `environment.sh`.  The virtualenv does not
need to be created in any particular place and `environment.sh` will respect an
already activated virtualenv. You might consider looking at `virtualenvwrapper`
(available on Ubuntu via `$ sudo apt-get install virtualenvwrapper`) as another
way to manage your virtualenvs.

The project dependencies may change from time to time. To trigger a reinstall,
`environment.sh` supports a `-i` flag:

`$ source environment.sh -i`

To reset your environment to its state before `source`ing the environment
script, simply run:

`$ deactivate`


Boto Config
-----------

The Ansible module this project uses to run instances in EC2 uses the Python
library `boto`. It will need a set of AWS credentials to run those instances.
Boto can be configured in a number of ways as described
[here](http://boto.readthedocs.org/en/latest/boto_config_tut.html). The simplest
method is probably to put them in `~/.boto` in the format mentioned in that
document.


Test
----

`$ ansible -m ping localhost`

If all is working, you should see some output that indicates ansible was able to
run the `ping` module on `localhost`.

=======
# szkolenie
WDI presentation:
https://docs.google.com/presentation/d/1-be6l1JeTCZ7qcuQnppoPTF89zx9Lpl2PlXbaf4Sa1U 
My recent article:
https://chmurowisko.pl/ansible-wystartuj-infrastructure-as-code-30-sekund-dziecinnie-proste/
Recent webinar:
https://www.youtube.com/watch?v=NjNZLBGmdaI

