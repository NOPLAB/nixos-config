{ ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.extra-substituters = [ "https://ros.cachix.org" ];
    settings.extra-trusted-public-keys = [
      "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
    ];

    gc = {
      automatic = true;
      dates = "weekly";
      # Remove generations older than 30 days, limiting rollback history.
      options = "--delete-older-than 30d";
    };

    optimise.automatic = true;
  };
}
