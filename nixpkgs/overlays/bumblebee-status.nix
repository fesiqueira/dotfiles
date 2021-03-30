self: super:
{
  bumblebee-status = super.python3.pkgs.buildPythonApplication rec {
    pname = "bumblebee-status";
    version = "2.1.4";
    name = "${pname}-${version}";
    src = super.python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "0wgsfykmvg98w35a16a69l9q6bfkvha706f16yrs4rhx9gjqmkcd";
    };
    doCheck = false;

    # ITS PROPAGATED fying idiot
    propagatedBuildInputs = [
      (super.python3.withPackages (ps: with ps; [
	psutil
	netifaces
	dbus-python
      ]))
    ];
  };
}
