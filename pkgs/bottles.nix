{ bottles, bottles-unwrapped }:

bottles.override {
  bottles-unwrapped = bottles-unwrapped.overrideAttrs (old: {
    # The dedicated ping endpoint returns HTTP 522. Check the official
    # component index instead, so its outage does not force offline mode.
    postPatch = (old.postPatch or "") + ''
      substituteInPlace bottles/backend/utils/connection.py \
        --replace-fail 'https://ping.usebottles.com' \
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
