{ pkgs, lib, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
  username = "bdossantos";
  homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
in
{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.packages =
    with pkgs;
    [
      # --- search & grep ---
      ack
      ripgrep
      silver-searcher
      ast-grep

      # --- file & directory utilities ---
      coreutils
      diffutils
      fd
      findutils
      moreutils
      tree
      eza
      entr
      watch

      # --- text processing ---
      gawk
      gnused
      gnugrep
      jq
      miller
      ed

      # --- compression ---
      advancecomp
      gzip
      pigz
      xz

      # --- image optimisation ---
      gifsicle
      jhead
      jpegoptim
      libjpeg
      optipng
      pngcrush
      pngquant

      # --- networking ---
      curl
      ipcalc
      nmap
      openssh
      wget

      # --- shells & prompts ---
      bash
      bash-completion
      starship

      # --- version control ---
      diff-so-fancy
      git
      gitlint
      lazygit
      tig

      # --- editors ---
      vim

      # --- terminal multiplexers ---
      tmux

      # --- gnu replacements ---
      gnutar
      gnupatch
      gnumake

      # --- languages & runtimes ---
      go
      go-jsonnet
      python3

      # --- ruby ---
      chruby
      ruby-build
      ruby-install

      # --- linters & formatters ---
      hadolint
      pre-commit
      nodePackages.prettier
      ruff
      shellcheck
      shfmt
      vale
      editorconfig-core-c

      # --- cloud & infrastructure ---
      awscli2
      k9s
      kops
      kubectx
      packer

      # --- security & crypto ---
      gnupg
      openssl

      # --- misc cli tools ---
      ansifilter
      bat
      cheat
      ctags
      fzf
      htop
      less
      lesspipe
      luarocks
      pv
      pwgen
      readline
      s3cmd
      stow
      tldr
      zoxide

      # --- libraries ---
      gsl
      libyaml

      # --- build tools ---
      bazel
      gcc
    ]
    ++ lib.optionals isDarwin [
      terminal-notifier
    ]
    ++ lib.optionals isLinux [
      binutils
      tcpdump
    ];
}
