#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright (C) 2012~2013 Deepin, Inc.
#               2012~2013 Kaisheng Ye
#
# Author:     Kaisheng Ye <kaisheng.ye@gmail.com>
# Maintainer: Kaisheng Ye <kaisheng.ye@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import os

qmldir_str = "module Deepin.Widgets"

widgets_dir = os.path.join(os.path.dirname(os.path.realpath(__file__)), "Widgets")

for f in os.listdir(widgets_dir):
    name, ext = os.path.splitext(f)
    if ext == ".qml":
        qmldir_str += "\n%s 1.0 %s" % (name, f)

with open(os.path.join(widgets_dir, 'qmldir'), "w") as fp:
    fp.write(qmldir_str)
