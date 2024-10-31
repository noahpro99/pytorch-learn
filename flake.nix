{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    # flake utils if you need to support other architectures
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell
        {
          buildInputs = with pkgs;
            [
              pkg-config
              rocmPackages.hipblas
              rocmPackages.clr
              rocmPackages.miopen
              rocmPackages.rocm-smi
              rocmPackages.rocsparse
              rocmPackages.rocsolver
              rocmPackages.rocblas
              rocmPackages.rocm-cmake
              rocmPackages.hipfft

              zlib
              (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
                matplotlib
                scikit-learn
                pandas
                ipykernel
                ipython
                pip

                torchWithRocm
              ]))
            ];
        };
    };
}
