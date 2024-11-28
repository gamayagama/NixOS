# NixOS configuration

## What is NixOS?

NixOS is a linux distribution based on the Nix expression language, commonly just referred to as Nix. Some key features include a declarative configuration model, reproducibility and easy rollback, a powerful package manager and much more.

The full brilliance of this distribution is beyond the scope of this README however, and so I suggest checking out the [NixOS website](https://nixos.org/) for more.

NOTE: The learning curve is pretty steep, and the documentation on the official website can be a bit overwhelming at first. I have left some resources further down that should provide a good starting point if you are interested!

## What is this?
This is my personal configuration of NixOS, and the various programs I use. Currently I only have it setup for my PC and laptop, but I plan to eventually include a configuration for a homelab and/or [VPS](https://en.wikipedia.org/wiki/Virtual_private_server) as well.

> [!IMPORTANT]
> It should be noted that this setup is still in it's infancy, and I cannot guarantee that it will work well, or at all, on your device. Please only use this a reference for now!

## Philosophy

As I develop this project, I aim for a setup that:

- Accommodates various needs
- Makes it easy to setup new hardware
- Is fully (or mostly) declarative
- Consists of highly readable code
- Is reasonably stable, optimised, and secure

## Structure

Below you will find an overview of the general file structure, and what the purpose of the different folders and files are. Keep in mind this may not reflect recent changes.
```
 ~/.config/nixos │
╭────────────────╯
├─ assets       ● Wallpapers/icons/themes/etc.
├─ bin          ● Scripts
├─ hosts
│  ├─ lethe     ● Main PC
│  ╰─ nyx       ● Laptop
├─ modules           
│  ├─ home      ● home-manager modules
│  ╰─ nixos     ● system (NixOS) modules
├─ users             
│  ╰─ gama      ● My home-manager config
└─ flake.nix    ● Initialise system
```
## Roadmap

This section is mostly a TODO list for myself, but hopefully it can be a source of inspiration as well!

- [x] Clean up general structure
- [x] Implement 'mkHost' function  
      - [example from notusknot](https://github.com/notusknot/dotfiles-nix/tree/a034dcb6daff31ce50cdbc74a5972b1ef56ef3d7)
- [x] Enable a formatter (Alejandra)
- [ ] Make greater use of the module setup, as seen in the gaming module
- [ ] Learn how to use Overlays and devShells
- [ ] Secret management  
      - [Available options](https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes)  
      - Agenix or sops-nix seems preferable
- [ ] Establish impermanence with tmpfs  
      - [Lan Tian's config](https://github.com/xddxdd/nixos-config/tree/55697a820bdc019d867ab52fa89e2b759c242b03)  
      - [community modules](https://github.com/nix-community/impermanence)
- [ ] Configure pre-commit hooks for Alejandra formatting
- [ ] Setup [Disko](https://github.com/nix-community/disko)
- [ ] Maybe [flake.parts](https://flake.parts/)?

## Resources

This book is a great place to start. Here I have linked to just the preface, but I highly recommend that you keep reading beyond that, at least the first few chapters.  
[Introduction and guide to NixOS](https://nixos-and-flakes.thiscute.world/preface) by [ryan4yin](https://github.com/sponsors/ryan4yin)

Alternatively, here is a video by Surma that I think does a good job of capturing a little bit of everything. It might be a good way to dip your toes into Nix, if going straight into the documentation still feels a bit overwhelming.  
[Nix explained from the ground up](https://www.youtube.com/watch?v=5D3nUU1OVx8)

Vimjoyer only started posting videos about Nix in 2023, but these have consistently been some of the best guides I have seen, covering a wide variety of concepts in an easily digestible format.  
[Vimjoyer's YouTube channel](https://www.youtube.com/@vimjoyer) 

Here is some official documentation on the Nix expression language. I should say that I have not gone through this entirely myself, but I think you will not get to really appreciate NixOS without at least understanding the basics of how Nix itself works.  
[Nix language basics](https://nix.dev/tutorials/nix-language.html)

Finally, here we have the documentation for how to install NixOS itself.
Bear in mind that this does not cover things like [home-manager](https://github.com/nix-community/home-manager) or [flakes](https://nixos.wiki/wiki/Flakes), and while I do think you will eventually want to explore these, it might be better not to take on too much all at once.  
[NixOS manual](https://nixos.org/manual/nixos/stable/)

> [!NOTE]
> While I do use flakes myself, I can't say that I fully understand them, and for that reason I have avoided sharing any resources on this topic specifically, but I hope some of the other resources mentioned have given you an idea as to where to look.

## Special thanks

This section contains some resources that have been helpful to my particular setup. While valuable resources, I decided not to include them in the section above, as I believe these are not necessarily helpful to complete beginners.

It should be noted that this list is not exhaustive. At this point I have gone through countless git repositories, youtube videos, and blog posts. So, I would like to thank everyone involved in the Nix community, even if I may not have included them below.


**Git repositories**  
[notusknot/dotfiles-nix](https://github.com/notusknot/dotfiles-nix)  
[Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)  
[fufexan/dotfiles](https://github.com/fufexan/dotfiles)  
[hutzdog/dotfiles](https://man.sr.ht/~hutzdog/dotfiles/)  
[hlissner/dotfiles](https://github.com/hlissner/dotfiles)  
[Icy-Thought/snowflake](https://github.com/Icy-Thought/snowflake/)  


**Other**  
[Nixology series](https://www.youtube.com/playlist?list=PLRGI9KQ3_HP_OFRG6R-p4iFgMSK1t5BHs) by Burke Libbey  
[Xe Iaso's blog](https://xeiaso.net/blog/)  
[FlakeHub](https://flakehub.com/flakes)  
[Noogle](https://noogle.dev/)
