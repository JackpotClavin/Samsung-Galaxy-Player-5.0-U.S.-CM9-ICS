# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
import re

import venturi_usa_common as common

class EdifyGenerator(object):
  """Class to generate scripts in the 'edify' recovery script language
  used from donut onwards."""

  def __init__(self, version, info):
    self.script = []
    self.mounts = set()
    self.version = version
    self.info = info

  def MakeTemporary(self):
    """Make a temporary script object whose commands can latter be
    appended to the parent script with AppendScript().  Used when the
    caller wants to generate script commands out-of-order."""
    x = EdifyGenerator(self.version, self.info)
    x.mounts = self.mounts
    return x

  @staticmethod
  def _WordWrap(cmd, linelen=80):
    """'cmd' should be a function call with null characters after each
    parameter (eg, "somefun(foo,\0bar,\0baz)").  This function wraps cmd
    to a given line length, replacing nulls with spaces and/or newlines
    to format it nicely."""
    indent = cmd.index("(")+1
    out = []
    first = True
    x = re.compile("^(.{,%d})\0" % (linelen-indent,))
    while True:
      if not first:
        out.append(" " * indent)
      first = False
      m = x.search(cmd)
      if not m:
        parts = cmd.split("\0", 1)
        out.append(parts[0]+"\n")
        if len(parts) == 1:
          break
        else:
          cmd = parts[1]
          continue
      out.append(m.group(1)+"\n")
      cmd = cmd[m.end():]

    return "".join(out).replace("\0", " ").rstrip("\n")

  def Ext4Stuff(self):
    self.script.append('package_extract_file("updater.sh", "/tmp/updater.sh");')
    self.script.append('set_perm(0, 0, 0777, "/tmp/updater.sh");')
    self.script.append('package_extract_file("make_ext4fs", "/tmp/make_ext4fs");')
    self.script.append('set_perm(0, 0, 0777, "/tmp/make_ext4fs");')
    self.script.append('package_extract_file("busybox", "/tmp/busybox");')
    self.script.append('set_perm(0, 0, 0777, "/tmp/busybox");')
    self.script.append('assert(run_program("/tmp/updater.sh") == 0);')

  def ExtractBoot(self):
    self.script.append('assert(package_extract_file("boot.img", "/tmp/boot.img"),')
    self.script.append('write_raw_image("/tmp/boot.img", "/dev/block/mmcblk0p11"),')
    self.script.append('delete("/tmp/boot.img"));')
    self.script.append('assert(package_extract_file("boot.img", "/tmp/boot.img"),')
    self.script.append('write_raw_image("/tmp/boot.img", "/dev/block/mmcblk0p12"),')
    self.script.append('delete("/tmp/boot.img"));')
