{ ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];

    gc = {
      automatic = true;
      dates = "weekly";
      # Remove generations older than 30 days, limiting rollback history.
      options = "--delete-older-than 30d";
    };

    optimise.automatic = true;
  };
}
