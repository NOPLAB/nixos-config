{ bottles, bottles-unwrapped }:

bottles.override {
  bottles-unwrapped = bottles-unwrapped.overrideAttrs (old: {
    # The dedicated ping endpoint returns HTTP 522. Check the official
    # component index instead, so its outage does not force offline mode.
    postPatch = (old.postPatch or "") + ''
      substituteInPlace bottles/backend/utils/connection.py \
        --replace-fail 'https://ping.usebottles.com' \
          'https://raw.githubusercontent.com/bottlesdevs/components/main/index.yml'
    '';
  });
}
