{ config, pkgs, lib, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "fesiqueira";
  home.homeDirectory = "/home/fesiqueira";

  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };

  home.packages = with pkgs; [
    discord
    htop
    libreoffice
    radeontop
    playerctl
    spotify
    teams
    wl-clipboard
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      menu = "rofi -modi 'drun,run' -show-icons -show drun | xargs swaymsg exec --";
      terminal = "alacritty";
      input."*" = { xkb_layout = "br"; };
      bars = [ { command = "waybar"; } ];
      keybindings = let modifier = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
	  "${modifier}+Shift+s" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -d)\" - | wl-copy -t image/png";
	  "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
	  "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
	  "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
	  "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
	  "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
	  "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
	};
      output = {
        HDMI-A-1 = {
	  resolution = "1920x1080";
	  position = "320 0";
	  bg = "~/Pictures/Wallpapers/ForestLandscape.jpg fill";
	};
	DP-3 = {
	  resolution = "2560x1080";
	  position = "0 1081";
	  bg = "~/Pictures/Wallpapers/TheNorthernForest.jpg fill";
	};
      };
    };
  };

  programs = {
    chromium.enable = true;
    alacritty.enable = true;
    jq.enable = true;
    rofi.enable = true;

    waybar = {
      enable = true;
      settings = [{
        modules-left = [ "sway/workspaces" "custom/spotify" ];
	modules-center = [ "sway/window" ];
	modules-right = [ "pulseaudio" "network" "cpu" "memory" "temperature" "clock" "tray" ];
	modules = {
	  "memory" = {
	    format = "{used:0.1f}G/{total:0.1f}G ";
	  };
	  "cpu" = {
	    format = "{usage}% ";
	  };
	  "clock" = {
	    format = "{:%d/%m/%Y %H:%M:%S} ";
	    tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
	  };
	  "temperature" = {
	    format = "{temperatureC}°C ";
	  };
	  "pulseaudio" = {
	    format = "{volume}% ";
	    format-source = "{volume}% ";
	    format-source-muted = "";
	    on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
	  };
	  "custom/spotify" = {
	    format = " {}";
	    return-type = "json";
	    max-length = 140;
	    escape = true;
	    on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
	    exec-if = "pgrep spotify";
	    exec = pkgs.writeShellScript "spotify-for-sway" ''
	      ${pkgs.playerctl}/bin/playerctl metadata --format '{"text": "{{artist}} - {{title}}"}' -F -p spotify
	    '';
	  };
	};
      }];
    };

    mako = {
      anchor = "top-left";
      backgroundColor = "#232a36";
      borderColor = "#000000";
      borderRadius = 3;
      defaultTimeout = 10000;
      enable = true;
      maxIconSize = 96;
      output = "DP-3";
    };

    git = {
      enable = true;
      userName = "Felipe Siqueira Pinheiro";
      userEmail = "fesiqueirapinheiro@gmail.com";
    };
  };

  services = {
    pulseeffects.enable = true;
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
