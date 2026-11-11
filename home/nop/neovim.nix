{ config, lib, ... }:

{
  xdg.configFile."nvim" = {
    source = ../../dotfiles/nvim;
    recursive = true;
  };

  # lazy.nvim needs a writable lockfile for plugin updates.
  home.activation.seedNeovimLockfile = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    lockfile="${config.xdg.dataHome}/nvim/lazy-lock.json"
    if [ ! -e "$lockfile" ]; then
      run mkdir -p "${config.xdg.dataHome}/nvim"
      run install -m 644 ${../../dotfiles/nvim/lazy-lock.json} "$lockfile"
    fi
  '';
}
