{ config, pkgs, lib, ... }: {

  boot.initrd.kernelModules = [ "nvidia" ];
  boot.blacklistedKernelModules = [ "noveau" ];

  boot.kernelModules = [ "nvidia" ];

  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = true;


  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
    open = false;
    prime = {
      offload.enable = true; #allows the GPU to turn of completly instead of idle
      sync.enable = false; #less needed on wayland
      intelBusId = "PCI:230:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # programs.steam.package = lib.mkForce pkgs.steam.override {
  #   withPrimus = true;
  # };
                            }
