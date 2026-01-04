{ pkgs, lib, ... }:

{
    home.packages = with pkgs; [
        pkgs.go
    ];
}