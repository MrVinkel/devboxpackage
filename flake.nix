{
  description = "devboxpackage test";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        lastTag = "v0.0.1";

        revision =
          if (self ? shortRev)
          then "${self.shortRev}"
          else "${self.dirtyShortRev or "dirty"}";

        # Add the commit to the version string for flake builds
        version = "${lastTag}";

        vendorHash = null;

        buildGoModule = pkgs.buildGo123Module;

      in
      {
        inherit self;
        packages.default = buildGoModule {
          pname = "devboxpackage";
          inherit version vendorHash;

          src = ./.;

          ldflags = [
            "-s"
            "-w"
          ];

          # Disable tests if they require network access or are integration tests
          doCheck = false;

          nativeBuildInputs = [ pkgs.installShellFiles ];

          meta = with pkgs.lib; {
            description = "devbox package test"; 
            homepage = "https://gitlab.com/mr_vinkel/devboxpackage";
            license = licenses.unlicense;
            maintainers = with maintainers; [ mr_vinkel ];
          };
        };
      }
    );
}