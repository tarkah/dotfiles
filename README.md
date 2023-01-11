# dotfiles

- Install `nix`

- Activate `home-manager`

```sh
# Linux
nix build .#homeConfigurations."tarkah".activationPackage

# Darwin
nix build .#homeConfigurations."tarkah@darwin".activationPackage

./result/activate
rm -rf result
```

- Switch profiles

```sh
# aliased to `home-manager switch --flake .#<system>`
update
```
