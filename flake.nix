{
  description = "MATLAB flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      targetPkgs =
        pkgs:
        (with pkgs; [
          cacert
          alsa-lib
          atk
          glib
          glibc
          cairo
          cups
          dbus
          fontconfig
          gdk-pixbuf
          gst_all_1.gst-plugins-base
          gst_all_1.gstreamer
          gtk3
          nspr
          nss
          pam
          pango
          python3
          libselinux
          libsndfile
          glibcLocales
          procps
          unzip
          zlib
          linux-pam
          gtk2
          at-spi2-atk
          at-spi2-core
          libdrm
          mesa
          gcc
          gfortran
          udev
          jre
          ncurses
          libxkbcommon
          xkeyboard_config
          libglvnd
          libuuid
          libxcrypt
          libxcrypt-legacy
          libgbm
        ])
        ++ (with pkgs.xorg; [
          libICE
          libSM
          libX11
          libxcb
          libXcomposite
          libXcursor
          libXdamage
          libXext
          libXfixes
          libXft
          libXi
          libXinerama
          libXrandr
          libXrender
          libXt
          libXtst
          libXxf86vm
        ]);
      runScriptPrefix = ''
        export QT_QPA_PLATFORM=xcb
        export LD_PRELOAD=/lib/libstdc++.so
        export LD_LIBRARY_PATH=/usr/llib/xorg/modules/dri:$LD_LIBRARY_PATH
        export INSTALL_DIR=$HOME/Vault/builds/matlab
      '';
    in
    {
      packages.x86_64-linux.matlab-shell = pkgs.buildFHSEnv {
        name = "matlab-shell";
        runScript = runScriptPrefix;
        inherit targetPkgs;
      };

      packages.x86_64-linux.matlab = pkgs.buildFHSEnv {
        name = "matlab";
        inherit targetPkgs;

        runScript = pkgs.writeScript "matlab-runner" (
          runScriptPrefix
          + ''
            exec $INSTALL_DIR/bin/matlab "$@"
          ''
        );
      };

      packages.x86_64-linux.matlab-mlint = pkgs.buildFHSEnv {
        name = "mlint";
        inherit targetPkgs;
        runScript = pkgs.writeScript (
          runScriptPrefix
          + ''
            exec $INSTALL_DIR/bin/glnxa64/mlint "$@"
          ''
        );
      };

    };
}
