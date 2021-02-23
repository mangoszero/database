[<img src='https://www.getmangos.eu/!assets_mangos/currentlogo.gif' width="48" border=0>](https://www.getmangos.eu)
[<img src='https://www.getmangos.eu/!assets_mangos/logo.png' border=0>](https://www.getmangos.eu)

---

[<img src="https://www.getmangos.eu/!assets_mangos/Mangos0.png" width="48" valign="middle"/>](http://getmangos.eu)
 **MangosZero - Vanilla World of Warcraft Database**
===

If you liked the original incarnation of [World of Warcraft][2] and still want to play it,
this is the branch for you. We provide an authentication server where you can manage your users, 
and a world server which serves game content just like the original did back then.

It aims to be 100% compatible with the 3 final versions of Vanilla [World of Warcraft][2], 
namely [patch 1.12.1][4], [patch 1.12.2][5] & [patch 1.12.3][6].
<br>**IT DOES NOT SUPPORT 1.13.x** and beyond which is the newly released Classic Experience (NuClassic).

Dependencies
------------
The server stands on the shoulders of several well-known Open Source libraries plus
a few awesome, but less known libraries to prevent us from inventing the wheel again.

**Please note that Linux and Mac OS X users should install packages using
their systems package management instead of source packages.**

* **MySQL** / **MariaDB**: to store content, and user data, we rely on
  [MySQL][40]/[MariaDB][41] to handle data.

<br>We have a small, but extremely friendly and helpful community managed by MadMax and Antz.
<br>Any trolling or unpleasantness is swiftly dealt with !!
- Our discord/forum motto is "Be nice or Be somewhere else"

**Official Website**
----

We welcome anyone who is interested in enjoying older versions of wow or contributing and helping out !

* [**Official MaNGOS Website**](https://getmangos.eu/)  

**Discord Server**
----
[![Widget for the Discord API guild](https://discord.com/api/guilds/286167585270005763/widget.png?style=banner2)](https://discord.gg/CzXcBXq) 

**Main Wiki**
----

The repository of as much information as we can pack in. Details regarding the Database, file type definitions, packet definitons etc.

* [**Wiki Table of Contents**](http://getmangos.eu/wiki)  


**Bug / Issue Tracker**
----

Found an issue or something which doesn't seem right, please log it in the relevant section of the Bug Tracker.

* [**Bug Tracker**](https://www.getmangos.eu/bug-tracker/mangos-zero/)

**How to Install**
----

**Linux**

Run: `InstallDatabases.sh` and follow the onscreen prompts.

**Windows**

Run: `InstallDatabases.bat` and follow the onscreen prompts.

**Installation Guides**
----

More comprehensive Installation instructions for various operation systems can be found here.

* [**Installation Guides**](https://www.getmangos.eu/wiki/documentation/installation-guides/) 


License
-------
This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
Street, Fifth Floor, Boston, MA 02110-1301 USA.

The full license is included in the file [LICENSE](LICENSE).

We have all put in hundreds of hours of time for free to make the server what it
is today.
<br>All we ask is that if you modify the code and make improvements, please have
the decency to feed those changes back to us.

In addition, as a special exception, permission is granted to link the code of
*Mangos* with the OpenSSL project's [OpenSSL library][48] (or with modified
versions of it that use the same license as the OpenSSL library), and distribute
the linked executables. You must obey the GNU General Public License in all
respects for all of the code used other than [OpenSSL][48].

Acknowledgements
--------
World of Warcraft, and all related art, images, and lore are copyright [Blizzard Entertainment, Inc.][1]


[1]: http://blizzard.com/ "Blizzard Entertainment Inc. · we love you!"
[2]: http://blizzard.com/games/wow/ "World of Warcraft · Classic / Vanilla"
[3]: http://wowpedia.org/Beta#World_of_Warcraft "World of Warcraft - Classic Beta"
[4]: http://www.wowpedia.org/Patch_1.12.1 "Vanilla WoW · Patch 1.12.1 release notes"
[5]: http://www.wowpedia.org/Patch_1.12.2 "Vanilla WoW · Patch 1.12.2 release notes"
[6]: http://www.wowpedia.org/Patch_1.12.3 "Vanilla WoW · Patch 1.12.3 release notes"
[7]: http://www.cppreference.com/ "C / C++ reference"

[10]: https://getmangos.eu/ "mangos · project site"
[12]: https://github.com/mangoszero "MaNGOS Zero · github organization"
[13]: https://github.com/mangoszero/server "MaNGOS Zero · server repository"
[15]: https://github.com/mangoszero/database "MaNGOS Zero · content database repository"
[16]: https://travis-ci.org/mangoszero/server "Travis CI · Linux/MAC build status"
[17]: https://ci.appveyor.com/ "AppVeyor Scan · Windows build status"
[19]: http://www.cmake.org/ "CMake · Cross Platform Make"
[20]: http://windows.microsoft.com/ "Microsoft Windows"
[21]: http://www.debian.org/ "Debian · The Universal Operating System"
[22]: http://www.ubuntu.com/ "Ubuntu · The world's most popular free OS"
[23]: http://www.freebsd.org/ "FreeBSD · The Power To Serve"
[24]: http://www.netbsd.org/ "NetBSD · The NetBSD Project"
[25]: http://www.openbsd.org/ "OpenBSD · Free, functional and secure"
[31]: https://visualstudio.microsoft.com/vs/older-downloads/ "Visual Studio Downloads"
[33]: http://clang.llvm.org/ "clang · a C language family frontend for LLVM"
[34]: http://git-scm.com/ "Git · Distributed version control system"
[35]: http://windows.github.com/ "github · windows client"
[36]: http://www.sourcetreeapp.com/ "SourceTree · Free Mercurial and Git Client for Windows/Mac"

[40]: http://www.mysql.com/ "MySQL · The world's most popular open source database"
[41]: http://www.mariadb.org/ "MariaDB · An enhanced, drop-in replacement for MySQL"
[43]: http://www.dre.vanderbilt.edu/~schmidt/ACE.html "ACE · The ADAPTIVE Communication Environment"
[44]: http://github.com/memononen/recastnavigation "Recast · Navigation-mesh Toolset for Games"
[45]: http://sourceforge.net/projects/g3d/ "G3D · G3D Innovation Engine"
[46]: http://zezula.net/en/mpq/stormlib.html "Stormlib · A library for reading data from MPQ archives"
[48]: http://www.openssl.org/ "OpenSSL · The Open Source toolkit for SSL/TLS"
[49]: http://www.stack.nl/~dimitri/doxygen/ "Doxygen · API documentation generator"
[51]: http://gnuwin32.sourceforge.net/packages/zlib.htm "Zlib for Windows"
[52]: http://gnuwin32.sourceforge.net/packages/bzip2.htm "Bzip2 for Windows"
[53]: http://www.zlib.net/ "Zlib"
[54]: http://www.bzip.org/ "Bzip2"
[55]: http://slproweb.com/products/Win32OpenSSL.html "OpenSSL for Windows"
