{ config, pkgs, lib, ... } : {
#sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = false;
  services.pipewire = {
    enable = true;
    jack.enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; #enable for qemu/quickemu
  };

#bloat
  services = {
    printing.enable = false;
    nscd.enable = false;
    avahi.enable = false;
    dbus.enable = true;
    xserver.enable = false;
  };
  system.nssModules = lib.mkForce [];
  systemd.oomd.enable = false;
  security.polkit.enable = true;


  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };


  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

#cpu optimization
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERN_ON_AC = "performance";
      CPU_SCALING_GOVERN_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
      TLP_DEFAULT_MODE = "BAT";
      TLP_PERSISTENT_DEFAULT = 1;
      SCHED_POWERSAVE_ON_BAT = 1;
      SCHED_POWERSAVE_ON_AC = 0;
      USB_AUTOSUSPEND = 1;
      PCIE_ASPM_ON_BAT = "powersupersave";
      WIFI_PWR_ON_BAT = "on";
      USB_BLACKLIST_BTUSB = 0;
    };
  };

                             }
