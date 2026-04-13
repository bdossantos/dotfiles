{ pkgs, ... }:

let
  username = "bdossantos";
  homeDirectory = "/Users/${username}";
in
{
  system.primaryUser = username;

  # Nix settings
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Homebrew — declaratively manage GUI / cask applications
  homebrew = {
    enable = true;
    prefix = "${homeDirectory}/.homebrew";

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };

    global = {
      autoUpdate = false;
    };

    caskArgs = {
      appdir = "~/Applications";
      fontdir = "~/Library/Fonts";
      no_binaries = true;
      require_sha = true;
    };

    brews = [
      "gcloud-cli"
    ];

    casks = [
      "1password"
      "anki"
      "firefox"
      "font-hack"
      "font-hack-nerd-font"
      "font-jetbrains-mono"
      "ghostty"
      "google-chrome"
      "gpg-suite"
      "imageoptim"
      "iterm2"
      "keybase"
      "little-snitch"
      "micro-snitch"
      "omnigraffle"
      "spotify"
      "tor-browser"
      "vagrant"
      "virtualbox"
      "vlc"
    ];
  };

  # Disable the macOS default ssh-agent
  system.activationScripts.postActivation.text = ''
    echo "Disabling macOS default ssh-agent..."
    launchctl disable "user/$(id -u ${username})/com.openssh.ssh-agent" 2>/dev/null || true
  '';

  system.stateVersion = 5;
}
