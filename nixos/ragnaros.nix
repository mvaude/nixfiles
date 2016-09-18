{ config, pkgs, ... }:

{
    imports = [ ./hw/dell-e7450.nix ];

    nixpkgs.config.allowUnfree = true;

    time = {
        timeZone = "Europe/Paris";
    };

    #i18n = {
    #    consoleKeyMap = "en";
    #    defaultLocale = "en_US.UTF-8";
    #};

    environment.systemPackages = with pkgs; [
        # Shells
        zsh

        # Editors
	atom
        (neovim.override { vimAlias = true; })

        # Browsers
	chromium
        firefoxWrapper

        git

        dmenu

        rxvt_unicode
	e19.terminology

        acpi
        file
        gparted
        htop
        pciutils
        tree
        wget
        curl

        nox

        # Others
        xlibs.xf86videointel
        vaapiIntel
    ];

    services = {
        fail2ban = {
            enable = true;
            jails.ssh-iptables = ''
                enable = true
            '';
        };

        acpid = {
            enable = true;
            lidEventCommands = ''
                grep -q closed /proc/acpi/button/lid/LID0/state && \
                /run/current-system/sw/bin/systemctl suspend
            '';
        };

        dbus = {
            enable = true;
        };

        devmon = {
            enable = true;
        };

        xserver = {
            enable = true;
            layout = "en";
            displayManager.slim.enable = true;

            videoDrivers = [ "intel" ];

            synaptics = {
                enable = true;
            };

            windowManager = {
                i3 = {
                    enable = true;
                };
                default = "i3";
            };
        };
    };

    fonts = {
        enableFontDir = true;
        enableGhostscriptFonts = true;
        fonts = with pkgs; [
            corefonts
            dejavu_fonts
            inconsolata
            liberation_ttf
            terminus_font
            ttf_bitstream_vera
            vistafonts
        ];
    };

    security.pam.enableEcryptfs = true;

    users.extraUsers = {
        maxter = {
            description = "Maxime Vaude";
            uid = 1000;
            extraGroups = [
                "adm"
                "audio"
                "cdrom"
                "dialout"
                "docker"
                "libvirtd"
                "networkmanager"
                "plugdev"
                "scanner"
                "systemd-journal"
                "tracing"
                "transmission"
                "tty"
                "usbtmc"
                "vboxusers"
                "video"
                "wheel"
                "wireshark"
            ];
            isNormalUser = true;
            initialPassword = "passit";
        };
    };
}
