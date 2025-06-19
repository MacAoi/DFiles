{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
 
  networking.networkmanager.enable = true; # Enable Networking

  time.timeZone = "Asia/Kolkata"; # Set your Timezone.

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.macaoi = {
    isNormalUser = true;
    description = "MacAoi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true; # Allow Unfree packages;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
 };
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

 environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.displayManager.sddm.enable=true;
  services.asusd.enable = true;
  services.xserver.enable = true;

# === === === === === === === === === === === === === === === #
  
  hardware.graphics = {
   enable = true;  #Enabling openGL
  };  

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
   
   modesetting.enable = true;
   powerManagement.enable = false;
   powerManagement.finegrained = false;
   open = true; # Nvidia open source driver(Recommended)
   nvidiaSettings = true; # Enable Nvidia settings menu
   package = config.boot.kernelPackages.nvidiaPackages.stable;

  };

  hardware.nvidia.prime = {
    nvidiaBusId = "PCI:1:0:0";
    amdgpuBusId = "PCI:6:0:0";
    sync.enable = true; # Better performace at the cost of Power Consumption
    offload = {
     enable = false; # Only use dGPU for specific applications you mentioned
     enableOffloadCmd = false;
    };
  };

  #boot.kernelParams = [ "module_blacklist=amdgpu" ];#Nope!


# === === === === === === === === === === === === === === === #
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  pkgs.git
  pkgs.neovim
  pkgs.ghostty
  pkgs.qimgv
  pkgs.firefox
  pkgs.rofi-wayland
  pkgs.asusctl
  pkgs.supergfxctl
  pkgs.btop
  pkgs.swww
  pkgs.obsidian
  pkgs.lshw
  pkgs.neofetch
  pkgs.tty-clock
  pkgs.yazi
  pkgs.xfce.thunar
  pkgs.themix-gui
  pkgs.qbittorrent
  pkgs.vlc
  pkgs.gimp3-with-plugins
  ];

  fonts.packages = with pkgs; [
   pkgs.nerd-fonts.jetbrains-mono   

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # services.openssh.enable = true; # Enable the OpenSSH daemon.

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05"; 

}
