{ ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.extra-substituters = [
      "https://ros.cachix.org"
      "https://cache.numtide.com"
    ];
    settings.extra-trusted-public-keys = [
      "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
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
