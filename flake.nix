{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
        isabelle-fhs = (pkgs.buildFHSEnv {
          name = "fhs-isabelle";
          targetPkgs = pkgs:
            with pkgs; [
              zlib
              fontconfig
              gtk3
              glib
              cairo
              pango
              expat
              cups
              libdrm
              atk
              mesa
              dbus
              nspr
              nss
              libudev0-shim
              alsa-lib
              libxkbcommon
              xorg.libX11
              xorg.libxcb
              xorg.libXrandr
              xorg.libXrender
              xorg.libXext
              xorg.libXcomposite
              xorg.libXfixes
              xorg.libXdamage
              xorg.libXtst
              xorg.libXi
            ];
          runScript = "bash";
        });
      in { devShell = isabelle-fhs.env; });
}
