# DOTFILES

Backup of my dotfiles using [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html).

To use the dotfiles, clone this repo and run

`stow .`

To add more configs to this folder use:

```sh
stow -v -R -t ~/.config .config
```

> [!NOTE]
> Use the `-n` option to simulate the changes without applying them.
