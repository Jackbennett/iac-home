
{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jack";
  home.homeDirectory = "/home/jack";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
  # The home.packages option allows you to install Nix packages into your
  # environment.

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.gnomeExtensions.volume-scroller-2
    pkgs.gnomeExtensions.advanced-alttab-window-switcher
    pkgs.nerd-fonts.fantasque-sans-mono
    pkgs.chezmoi

    # # You can also create simple rbash scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.nil # Nix LSP
    pkgs.git
    pkgs.gh
    pkgs.nmap
    pkgs.dig
    pkgs.freecad
    pkgs.k9s
    pkgs.pciutils
    pkgs.alsa-utils
    pkgs.docker
    pkgs.usbutils
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jack/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };

#  services.xserver.xkb.extraLayouts = {
#    sessionCommands = ${pkgs.xorg.xmodmap}/bin/xmodmap "${pkgs.writeText "xkb-layout" ''
#      remove Lock = Caps_Lock
#      key <PGUP> { [void] }
#      key <PGDN> { [void] }
#    ''}"
#  };

  # programs.fusuma

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set number relativenumber
      set tabstop=2
      set expandtab
    '';
  };

  programs = {
    bash.enable = true;
    bash.shellAliases = {
        g = "git";
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
    nushell = {
      enable = false;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      # configFile.source = /home/jack/.config/nushell/config.nu;
      # for editing directly to config.nu 
      extraConfig = ''
        let carapace_completer = {|spans|
        carapace $spans.0 nushell $spans | from json
        }
        $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false # case-sensitive completions
        quick: true    # set to false to prevent auto-selecting completions
        partial: true    # set to false to prevent partial filling of the prompt
        algorithm: "fuzzy"    # prefix or fuzzy
        external: {
        # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true 
        # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100 
            completer: $carapace_completer # check 'carapace_completer' 
          }
        }
        } 
        $env.PATH = ($env.PATH | 
        split row (char esep) |
        prepend /home/myuser/.apps |
        append /usr/bin/env
        )
        '';
        shellAliases = {
          vi = "hx";
          vim = "hx";
          nano = "hx";
        };
    };
    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
       enable = true;
       settings = {
         add_newline = true;
         character = { 
         success_symbol = "[➜](bold green)";
         error_symbol = "[➜](bold red)";
       };
      };
    };
  };

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions= [ 
        "volume_scroller@francislavoie.github.io"
        "keyboard-backlight-menu@ophir.dev"
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      move-to-workspace-up = [];
      move-to-workspace-down = [];
    };
  };

  imports = [
    ./lang-golang.nix
  ];
}
