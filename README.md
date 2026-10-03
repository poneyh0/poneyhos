# PoneyhOS

This repository builds my own custom [bootc](https://github.com/bootc-dev/bootc)
image. It is based on `quay.io/fedora/fedora-kinoite:44` with some custom
packages on top of it. This project also uses the incredible work done by
Universal Blue community with [image-template](https://github.com/ublue-os/image-template)
project to create the image and automatize through CI the distribution of the
image.

## Community

- [Universal Blue Forums](https://universal-blue.discourse.group/)
- [Universal Blue Discord](https://discord.gg/WEu6BdFEtp)

## How to Use

From your bootc system, run the following command:

```bash
sudo bootc switch ghcr.io/poneyh0/poneyhos
```

This should queue the image for the next reboot.

## How to install

Currently, no iso image is available to install PoneyhOS.
Here are the instructions to be able to deploy the operating system on your
computer:

- Download the latest kinoite version 44 on [fedoraproject](https://fedoraproject.org/atomic-desktops/kinoite/download/)
- If the download of the ISO is very slow, consider downloading via torrent on
  [fedoraproject torrents](https://fedoraproject.org/torrents/44/)
- Create a bootable usb key with [Fedora Image Writer](https://github.com/FedoraQt/MediaWriter)
  with the Kinoite iso.
- Reboot your computer and boot on the USB key.
- Install Kinoite
- Reboot at the end of the install and remove the USB key.
- Continue the installation process after booting on Fedora Kinoite
- On Kinoite, open a terminal and run the following:

```bash
sudo bootc switch ghcr.io/poneyh0/poneyhos
```

- Reboot your computer with:

```bash
systemctl reboot
```

- Welcome to PoneyhOS!

## Post-install steps

### Vicinae

- Open **Settings** and go to **Keyboard** and **Shortcuts**
- Select **KRunner**
- Expand **Launch** and uncheck **Alt + Space**
- We recommend adding a custom shortcut with **Ctrl + Space** to **KRunner**
  to keep a fast shortcut because of its close integration in **KDE**
- Click on **Add New**
- Select **Application**
- Search for **Vicinae** and click **Ok**
- In the panel, select **Vicinae**
- Unfold **Toggle Vicinae Window**
- Add custom shortcut **Alt + Space**

### Glass theme

#### Setup

- Open **Settings** and go to **Window Management**
- Select **Desktop Effects**
- Uncheck **Blur**
- Ensure **Translucency** is unchecked.
- Check **Glass**
- In left panel, select **Colors & Themes**
- Select **Colors**
- Select either **Dark** or **Light** for **Glass**
- Click **Apply**
- Select **Application Style** in the central panel
- Select **Glass** and click **Apply**
- In central panel, select **Window Decorations**
- Select **Glass**

#### Desktop Customization

- In **Window Decorations** settings, click on **Edit Glass Theme...**
- Set **Button Style** to **Small**
- Click **Ok**
- You can customize the location of the button by clicking on
  **Configure Titlebar Buttons...**
- In **Colors**, you can set up an **Accent Color**
- In central panel, you can click on **Global Theme** and **Get New...**
- Install a transparent theme, such as _Apple macOS Tahoe_
- In **Global Theme** panel, select your downloaded theme
- In the **Apply** dialog, ensure both checkboxes are checked.
- Click on **OK**

#### Glass Customization

- In **Settings**, click on **Window Management**
- In central panel, click on **Desktop Effects**
- On the **Glass** effect, click on the **Configure** button located at the
  right
- In this dialog, you can fine tune the blur and the refraction effect for
  instance or set rounded corners for your desktop windows.

## Build locally

You can build the image on your own computer to test your changes before
pushing them. All the commands below must be run on the host, not inside a
toolbx: a toolbx has its own podman storage, and `bootc` would not see the
image built there.

- Clone the repository:

```bash
git clone https://github.com/poneyh0/poneyhos.git
cd poneyhos
```

- Build the image as root, so it lands directly in the root containers-storage
  where `bootc` can find it:

```bash
sudo podman build -t localhost/poneyhos:latest .
```

- Optionally, open a shell in the image to check its content:

```bash
sudo podman run --rm -it localhost/poneyhos:latest bash
```

- Switch to the local image and reboot:

```bash
sudo bootc switch --transport containers-storage localhost/poneyhos:latest
systemctl reboot
```

- If something is wrong, go back to the previous deployment with:

```bash
sudo bootc rollback
systemctl reboot
```

While you are on the local image, `bootc upgrade` will not pull the published
updates. To go back to the published image, run:

```bash
sudo bootc switch ghcr.io/poneyh0/poneyhos
```

The `Justfile` also provides recipes to build virtual machine images, ISOs or
to rechunk the image, see [docs/Justfile.md](docs/Justfile.md).
