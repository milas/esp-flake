# Versions based on
# https://dl.espressif.com/dl/esp-idf/espidf.constraints.v5.3.txt
# on 2025-01-02.
{
  stdenv,
  lib,
  fetchPypi,
  fetchFromGitHub,
  pythonPackages,
}:
with pythonPackages; rec {
  idf-component-manager = buildPythonPackage rec {
    pname = "idf-component-manager";
    version = "1.3.2";

    src = fetchFromGitHub {
      owner = "espressif";
      repo = pname;
      rev = "v${version}";
      sha256 = "sha256-rHZHlvRKMZvvjf3S+nU2lCDXt0Ll4Ek04rdhtfIQ1R0=";
    };

    # For some reason, this 404s.
    /*
    src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-12ozmQ4Eb5zL4rtNHSFjEynfObUkYlid1PgMDVmRkwY=";
    };
    */

    doCheck = false;

    propagatedBuildInputs =
      [
        cachecontrol
        cffi
        click
        colorama
        packaging
        pyyaml
        requests
        requests-file
        requests-toolbelt
        schema
        six
        tqdm
      ]
      ++ cachecontrol.optional-dependencies.filecache;

    # setup.py says it needs these deps, but it actually doesn't. contextlib2
    # isn't supported on some pythons and urllib3 is pinned to an old version
    postPatch = ''
      sed -i '/contextlib2/d' setup.py
      sed -i '/urllib3/d' setup.py
    '';

    meta = {
      homepage = "https://github.com/espressif/idf-component-manager";
    };
  };

  esp-coredump = buildPythonPackage rec {
    pname = "esp-coredump";
    version = "1.12.0";

    pyproject = true;
    build-system = [
      setuptools
    ];

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-s/JKD9PwcU7OZ3x4U4ScCRILvc1Ors0hkXHiRV+R+tg=";
    };

    doCheck = false;

    propagatedBuildInputs = [
      construct
      pygdbmi
      esptool
    ];

    meta = {
      homepage = "https://github.com/espressif/esp-coredump";
    };
  };

  esptool = buildPythonPackage rec {
    pname = "esptool";
    version = "4.8.1";

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-3E7ya2WeGo3LAZFHwOptlJgLNN6Z++CRIceUHIslRTE=";
    };

    doCheck = false;

    propagatedBuildInputs = [
      bitstring
      cryptography
      ecdsa
      pyserial
      reedsolo
      pyyaml
    ];

    meta = {
      homepage = "https://github.com/espressif/esptool";
    };
  };

  esp-idf-kconfig = buildPythonPackage rec {
    pname = "esp-idf-kconfig";
    version = "2.4.1";

    pyproject = true;
    build-system = [
      setuptools
    ];

    src = fetchPypi {
      inherit version;
      pname = "esp_idf_kconfig";
      sha256 = "sha256-GObE8PZlSNy4wWb/HhgJ1hZJrD0dGUzzgB72wKwcnVo=";
    };

    doCheck = false;

    propagatedBuildInputs = [
      argcomplete
      kconfiglib
      intelhex
      rich
    ];

    meta = {
      homepage = "https://github.com/espressif/esp-idf-kconfig";
    };
  };

  esp-idf-monitor = buildPythonPackage rec {
    pname = "esp-idf-monitor";
    version = "1.1.1";

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-c62X3ZHRShhbAFmuPc/d2keqE9T9SXYIlJTyn32LPaE=";
    };

    doCheck = false;

    propagatedBuildInputs = [
      pyserial
      esp-coredump
      pyelftools
    ];

    meta = {
      homepage = "https://github.com/espressif/esp-idf-monitor";
    };
  };

  esp-idf-size = buildPythonPackage rec {
    pname = "esp-idf-size";
    version = "1.6.1";

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-Oki21JiHiS7PzfIj/uQXSjc1KArRKBEDDLRvpQqBI/o=";
    };

    doCheck = false;

    propagatedBuildInputs = [
      pyyaml
    ];

    meta = {
      homepage = "https://github.com/espressif/esp-idf-size";
    };
  };

  freertos_gdb = buildPythonPackage rec {
    pname = "freertos-gdb";
    version = "1.0.2";

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-o0ZoTy7OLVnrhSepya+MwaILgJSojs2hfmI86D9C3cs=";
    };

    doCheck = false;

    propagatedBuildInputs = [
    ];

    meta = {
      homepage = "https://github.com/espressif/freertos-gdb";
    };
  };

  esp-idf-panic-decoder = buildPythonPackage rec {
    pname = "esp-idf-panic-decoder";
    version = "1.2.1";

    format = "pyproject";

    src = fetchPypi {
      inherit version;
      pname = "esp_idf_panic_decoder";
      sha256 = "sha256-hC8Rje/yMj5qyY8hgErviR4WV3hC0vNCdCQboKXVTYI=";
    };

    doCheck = false;

    propagatedBuildInputs = [
      setuptools
      pyelftools
    ];

    meta = {
      homepage = "https://github.com/espressif/esp-idf-panic-decoder";
    };
  };

  esp-idf-nvs-partition-gen = buildPythonPackage rec {
    pname = "esp-idf-nvs-partition-gen";
    version = "0.1.6";

    format = "pyproject";

    src = fetchPypi {
      pname = "esp_idf_nvs_partition_gen";
      inherit version;

      sha256 = "sha256-511QNGnWJun37fOcH+A923mXM4YDWw/E0kppnNcdiJQ=";
    };

    propagatedBuildInputs = [
      setuptools
      cryptography
    ];

    doCheck = false;

    meta = {
      homepage = "https://github.com/espressif/esp-idf-nvs-partition-gen";
    };
  };

  pyclang = buildPythonPackage rec {
    pname = "pyclang";
    version = "0.6.0";

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-G+Y24AiTOpjLg+eQGAT/CTCK0/vomqjNZloXTmWqRQM=";
    };

    doCheck = false;
  };
}
