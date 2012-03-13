#
# Copyright (C) 2008 The Android Open Source Project
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

import os, sys

LOCAL_DIR = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
RELEASETOOLS_DIR = os.path.abspath(os.path.join(LOCAL_DIR, '../../../build/tools/releasetools'))

import edify_generator

class EdifyGenerator(edify_generator.EdifyGenerator):
    def UnpackPackageFile(self, src, dst):
      """Unpack a given file from the OTA package into the given
      destination file."""
      self.script.append('package_extract_file("%s", "%s");' % (src, dst))

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
