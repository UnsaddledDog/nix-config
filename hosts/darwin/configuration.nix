{
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/homebrew
  ];

  # services = {
  #   nix-daemon.enable = true;
  # };

  system.defaults = {
    dock = {
      autohide = true;
      expose-group-apps = true;
      magnification = false;
      mru-spaces = false;
      show-recents = false;
      tilesize = 48;
      persistent-apps = [
        "/System/Applications/Launchpad.app/"
        "/Applications/Firefox.app/"
        "/Applications/TIDAL.app/"
        "/Applications/Spotify.app/"
        "/Applications/rekordbox 7/rekordbox.app/"
        "/Applications/Ableton Live 12 Suite.app/"
        "/Applications/Ghostty.app/"
        "/Applications/Notability.app"
        "/Applications/Anki.apP/"
        "/Applications/Notion.app/"
        "/System/Applications/System Settings.app/"
      ];
    };

    finder = {
      AppleShowAllExtensions = true;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = false;
    };
  };

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set user
  users.users.gergo = {
    name = "gergo";
    home = "/Users/gergo";
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    tidal-dl
    nodePackages.peerflix
  ];

  # It's not enough to enable zsh in home manager
  programs.zsh.enable = true;

  system.stateVersion = 5;
}
