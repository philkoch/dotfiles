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


# systemd-services

In `.config/systemd/users/` some systemd services can be found. If the dotfiles are added
to a new machine, run

```sh
systemd --user daemon-reload
systemd --user enable taskwarrior_daily.timer
systemd --user enable taskwarrior_high_council.timer

systemd --user start taskwarrior_daily.timer
systemd --user start taskwarrior_high_council.timer
```

| service | description |
| ------- | ----------- |
| taskwarrior_daily | creates a task for the Daily meeting in taskwarrior every day |
| taskwarrior_high_council | creates a task for the High Council meeting in taskwarrior every day |




