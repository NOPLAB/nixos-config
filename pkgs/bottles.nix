{ bottles, bottles-unwrapped, fetchFromGitHub, python3Packages }:

bottles.override {
  bottles-unwrapped = bottles-unwrapped.overrideAttrs (old: {
    # Office Click-to-Run needs the new installer and runner integration.
    version = "67.6-unstable-2026-11-17";
    src = fetchFromGitHub {
      owner = "bottlesdevs";
      repo = "Bottles";
      rev = "5aab7830912cf9f038de962ad3a82f2e818643da";
      hash = "sha256-skZUsnNbt3indVEnsQxbYtgpSM+T5iJCBX0CfBTKI/I=";
    };
    # The Soda sign-in bridge starts a child Python process. It needs the
    # same dependencies as Bottles, including PyGObject and PyYAML.
    preFixup = (old.preFixup or "") + ''
      makeWrapperArgs+=(--prefix PYTHONPATH : "${python3Packages.makePythonPath old.propagatedBuildInputs}")
    '';
    # Keep the existing direct GitHub catalog fallback.
    postPatch = (old.postPatch or "") + ''
      substituteInPlace bottles/backend/utils/connection.py \
        --replace-fail 'https://proxy.usebottles.com/repo/components/' \
          'https://raw.githubusercontent.com/bottlesdevs/components/main/index.yml'
      substituteInPlace bottles/backend/managers/repository.py \
        --replace-fail 'https://proxy.usebottles.com/repo/components/' \
          'https://raw.githubusercontent.com/bottlesdevs/components/main/' \
        --replace-fail 'https://proxy.usebottles.com/repo/dependencies/' \
          'https://raw.githubusercontent.com/bottlesdevs/dependencies/main/' \
        --replace-fail 'https://proxy.usebottles.com/repo/programs/' \
          'https://raw.githubusercontent.com/bottlesdevs/programs/main/'
    '';
  });
}
