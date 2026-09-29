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
- Install a transparent theme, such as *Apple macOS Tahoe*
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

## Additional resources

For additional driver support, ublue maintains a set of scripts and container
images available at [ublue-akmod](https://github.com/ublue-os/akmods). These
images include the necessary scripts to install multiple kernel drivers within
the container (Nvidia, OpenRazer, Framework...). The documentation provides
guidance on how to properly integrate these drivers into your container image.
