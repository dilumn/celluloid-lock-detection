# celluloid-lock-detection

**Development begun during Google Summer of Code, 2015**

> Lock detection for managed Celluloid actors.

Detect and announce locked tasks for threaded and fibered actors.

Future Development
------------------

Threaded & Fibered tasks will be converted to Unlockable Threaded & Unlockable Fibered with `$CELLULOID_LOCKDETECTOR ||= true`
It will be the next step of LockDetector with deadlock Unlock features

Contributing to celluloid-lock-detection
----------------------------------------

* Fork this repository on github
* Make your changes and send us a pull request
* If we like them we'll merge them
* If we've accepted a patch, feel free to ask for commit access

License
-------

Copyright (c) 2011-2015 Tony Arcieri, Donovan Keme, Dilum Navanjana.
Distributed under the MIT License. See [LICENSE.txt](https://github.com/celluloid/celluloid-lock-detection/blob/master/LICENSE.txt) for further details.
