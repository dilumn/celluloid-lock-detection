# celluloid-lock-detection

**Development begun during Google Summer of Code, 2015**

In systems with complex interaction between Actors, it is possible for deadlocks to occur. This is particularly true when using the exclusive feature to force in-order processing of messages. Finding and debugging these deadlocks is very difficult. So you can use this celluloid-lock-detection for detecting deadlocks than getting thousands of lines error messages. This feature only enables for Managed Actors in Celluloid & it works on both threaded and fibered actors.

`DEADLOCK Detected in the Actor System.` You will see this warning if the system detects deadlocks.

Make `$CELLULOID_LOCKDETECTOR ||= true` to enable LockDetector

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
