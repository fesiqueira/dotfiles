{ fetchFromGitHub, lib, python38Packages }:

python38Packages.buildPythonApplication rec {
  pname = "bumblebee-status";
  version = "2.1.4";
  src = fetchFromGitHub {
    owner = "tobi-wan-kenobi";
    repo = pname;
    rev = "v${version}";
    sha256 = "dahufuhasd";
  };

  enableParallelBuilding = true;
  meta = with lib; {
    description = "bumblebee-status is a modular, theme-able status line generator for the i3 window manager.";
    license = licenses.mit;
    homepage = "https://github.com/tobi-wan-kenobi/bumblebee-status/";
    platforms = platforms.linux;
  };
}
