@rem Copyright 2017 gRPC authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem     http://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.

@rem Move python installation from _32bit to _32bits where they are expected python artifact builder
@rem TODO(jtattermusch): get rid of this hack
rename C:\Python27_32bit Python27_32bits
rename C:\Python34_32bit Python34_32bits
rename C:\Python35_32bit Python35_32bits
rename C:\Python36_32bit Python36_32bits

pacman -S --noconfirm mingw64/mingw-w64-x86_64-gcc mingw32/mingw-w64-i686-gcc

@rem make sure msys binaries are preferred over cygwin binaries
@rem set path to python 2.7
set PATH=C:\tools\msys64\usr\bin;C:\Python27;%PATH%


@rem enter repo root
cd /d %~dp0\..\..\..

git submodule update --init

python tools/run_tests/task_runner.py -f artifact windows || goto :error
goto :EOF

:error
exit /b %errorlevel%
