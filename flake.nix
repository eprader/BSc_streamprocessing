{
  description = "Environment for the BSc of Emanuel Prader";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };

    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [

            ansible
            # glibcLocales

            kubectl
            kubernetes-helm
          ];

          shellHook = ''
            export PS1="(nix-shell) $PS1" # NOTE: To communicate that a nix shell is active
            export KUBECONFIG=$(pwd)/.kube/config
          '';
        };
      };
    };
}
