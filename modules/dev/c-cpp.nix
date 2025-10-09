{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.dev.language.c-cpp;
  llvm = pkgs.llvmPackages_21;
in
{
  config = lib.mkIf cfg {
    home = {
      packages =
        with pkgs;
        [
          llvm.llvm
          llvm.libcxx
          llvm.lldb
          llvm.clang
          llvm.clang-tools
          gnumake
        ]
        ++ (
          if pkgs.stdenv.isLinux then
            [
              glibc.dev
              valgrind
            ]
          else
            [ ]
        );
      sessionVariables = {
        MallocNanoZone = 0;
      };
    };
  };
}
