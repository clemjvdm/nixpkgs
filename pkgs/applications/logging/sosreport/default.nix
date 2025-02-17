{ lib
, buildPythonPackage
, fetchFromGitHub
, gettext
, magic
, pexpect
, pyyaml
, setuptools
}:

buildPythonPackage rec {
  pname = "sosreport";
  version = "4.8.1";

  src = fetchFromGitHub {
    owner = "sosreport";
    repo = "sos";
    rev = "refs/tags/${version}";
    sha256 = "sha256-tnc0mAWk3IqQVRLj5oDhJSG4o27Ogv/Ce6oGEZ6AamM=";
  };

  nativeBuildInputs = [
    gettext
  ];

  propagatedBuildInputs = [
    magic
    pexpect
    pyyaml
    setuptools
  ];

  # requires avocado-framework 94.0, latest version as of writing is 96.0
  doCheck = false;

  preCheck = ''
    export PYTHONPATH=$PWD/tests:$PYTHONPATH
  '';

  pythonImportsCheck = [ "sos" ];

  meta = with lib; {
    description = "Unified tool for collecting system logs and other debug information";
    homepage = "https://github.com/sosreport/sos";
    license = licenses.gpl2Only;
    maintainers = [ ];
  };
}
