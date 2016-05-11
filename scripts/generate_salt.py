#!/usr/bin/env python

"""
Generate WordPress salt from ascii characters.
"""

import string, random


salt = ''.join(random.choice(string.ascii_lowercase) for _ in xrange(70))
print salt
