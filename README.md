# dotfiles

- Install `nix`

- Activate `home-manager`

```sh
# <profile> is linux, darwin or work
nix build .#homeConfigurations."tarkah@<profile>".activationPackage

./result/activate
rm -rf result
```

- Update profile

```sh
# aliased to `home-manager switch --flake .#<system>@<profile>`
update
```
