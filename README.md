My personal flake for installing and running MATLAB on NixOS. The only thing specific to my system is manually setting the `INSTALL_DIR` variable to `$HOME/Vault/builds/matlab`.

## Weird updater behaviour
See [here](https://www.mathworks.com/matlabcentral/answers/2141906-how-can-i-stop-the-mathworks-service-host-from-running-on-startup).

## Previous work.
Completely based off [@doronbehar's](https://gitlab.com/doronbehar) work on [nix-matlab](https://gitlab.com/doronbehar/nix-matlab). `libICE` is an added dependency for R2025a that's not included in Doron's repo.
