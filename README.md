# NixOS config

This repository contains the dotfiles that I use to configure my linux systems and the software that I use regularly. This is all powered by NixOS, Nixpkgs and the Nix expression language. To learn more about Nix, please visit the [NixOS website](https://nixos.org/).

## My experience with Nix

Nix as a whole is very different from anything I have dealt with before, and I am by no means a seasoned developer to begin with, so getting to a setup that met my needs was, and continues to be, a long (and often difficult) journey.

Through a lot of trial and error, I have however managed to simplify things for myself, after struggling to imitate some of the more sophisticated (i.e. complex) configurations that other people have come up with. Below I will describe in more detail how my configuration is structured.

## Words of warning

Please note that this repository may see sudden, drastic changes, and is not at any given moment guaranteed to work for anyone but myself (sometimes not even that is guaranteed). With that in mind, feel free to take a look around and use any part of my configuration that you find useful.

## Structure

The main structure of the repository, as shown below, consists of three top-level folders: hosts, scripts, and users, as well as the flake.nix file in the root of the repository.

```
.dotfiles
├─ hosts/
│ ├─ {hostname}/
│ ├─ common/
│ └─ default.nix
├─ scripts/
├─ users/
│ ├─ {username}/
│ ├─ common/
│ └─ default.nix
└─ flake.nix
```

NOTE: this structure is not final. As I learn more, I may still add or remove certain elements, but the goal will remain to keep the system as organised and easy to understand as possible.

### flake.nix

The flake.nix file is the entrypoint for the system. It contains a set of **inputs**, which can be thought of as the dependencies that the system requires to successfully build itself. The flake.nix also contains some **outputs**. These are what dictates how the system actually gets build.

In this case, you will see a let block, which I use to set some variables, that I then use to build my nixosConfigurations and my homeConfigurations. These handle the NixOS system configuration and the home-manager configuration respectively.

Home-manager is simply put a tool to configure things on a per-user basis. It also provides a large amount of configuration options that are not available in the system configuration.

For more information, visit the [home-manager repository](https://github.com/nix-community/home-manager).

### hosts

The _hosts_ folder contains everything needed for the system configuration. First and foremost, it contains a _default.nix_ file, which gets loaded in the flake.nix file.

NOTE: you may have noticed that the flake.nix file did not specify a specific file, but rather it just specified the hosts folder. This is because the Nix language will automatically look for a default.nix file whenever a folder is provided instead of a specific file. This will be a recurring theme for my configuration.

So, the default.nix file passes specific configuration files for each host machine to the flake. In my case you see athena and Terra, which refers to my laptop and my main PC respectively. In both cases it loads a _common_ folder, once again relying on the "default" behavior. Each host also loads its own folder.

It is important to note that these hosts can be called anything, but they should ideally match the hostname of the machine, as seen by running the `hostname` command. The hostname is also defined within the hardware section of the hosts configuration.

The host-specific folders mainly contain hardware configurations, however the common folder contains folders for a variety of different things including the system fonts, networking, the X window system, and more.

Each of these folders can be thought of as modules, which means they could just as well be loaded on a specific host, if for example both hosts need the X window system running, but one needs a full desktop environment such as plasma5, whereas the other needs a more minimal setup with a tiling window manager, like qtile.

### users

The _users_ folder works more or less exactly like the hosts folder, with the exception being that all the configurations are applied to a user instead of a host machine, and like mentioned earlier, there is a larger set of configuration options.

NOTE: There are some configuration options that overlap, but some options will only work in home-manager configurations and some will only work in the system configuration, so make sure you are checking which options are available depending on what you are configuring.

### scripts

The _scripts_ folder is simply put where I store some of the scripts that I use to manage my system.
Specifically, it contains an _update_ script, which checks for package updates, an _applySystem_ script, which applies the system configuration, an applyUsers script, which applies the home-manager configuration, and finally a fwupd script, which checks for firmware upgrades and applies them, if any is available.

It is possible to use home-manager as a module within the system configuration, which would remove the need for the applyUsers script, however I have had better experiences keeping them separate so far. I may revisit this later though.

## Special thanks

My sincere thanks to the people managing the below repositories, for showing me what was truly possible, and for teaching me how to do certain things when the official documentation felt a little too daunting, and most importantly, for inspiring me to do something much simpler, when failing to do what they managed to do.

[hutzdog](https://man.sr.ht/~hutzdog/dotfiles/)

[Henrik Lissner](https://github.com/hlissner/dotfiles)

[Gabriel Volpe](https://github.com/gvolpe/nix-config)

[Sridhar Ratnakumar](https://github.com/srid/nixos-config)

[Icy Thought](https://github.com/Icy-Thought/Snowflake)
