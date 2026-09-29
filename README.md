# PoneyhOS

This repository build my own custom [bootc](https://github.com/bootc-dev/bootc)
image. It is based on u-blue/Aurora with some custom packages on top of it.

## Community

- [Universal Blue Forums](https://universal-blue.discourse.group/)
- [Universal Blue Discord](https://discord.gg/WEu6BdFEtp)

## How to Use

From your bootc system, run the following command:

```bash
sudo bootc switch ghcr.io/poneyh0/poneyhos
```

This should queue the image for the next reboot.

## Additional resources

For additional driver support, ublue maintains a set of scripts and container
images available at [ublue-akmod](https://github.com/ublue-os/akmods). These
images include the necessary scripts to install multiple kernel drivers within
the container (Nvidia, OpenRazer, Framework...). The documentation provides
guidance on how to properly integrate these drivers into your container image.
