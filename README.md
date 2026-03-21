# 2048-Qt

A clone of [2048](https://github.com/gabrielecirulli/2048), implemented in Qt.

> [!NOTE]
> This is a fork of the original [2048-Qt](https://github.com/xiaoyong/2048-Qt) project with several improvements.

## Features

- Cross platform  
  Currently tested on Windows and Linux. Should be able to run on Mac OS X or even Android and iOS.
- Shipped with multiple variants
  - 2048
  - Degree (学位)
  - Military Rank (军衔)
  - PRC (天朝)
- Multi-language support, currently
  - English
  - French (by [Rémi Verschelde](https://github.com/akien-mga))
  - German (by [Jens John](https://github.com/2ion))
  - Polish (by [Michał Radwański](https://github.com/enedil))
  - Russian (by [Sergey Basalaev](https://github.com/SBasalaev))
  - Simplified Chinese

## Screenshots

- Light Mode
  ![Screenshot of 2048-Qt Light Mode](res/screenshots/screenshot_light.png)

- Dark Mode
  ![Screenshot of 2048-Qt Dark Mode](res/screenshots/screenshot_dark.png)

## Downloads

Check [releases](https://github.com/mnabid/2048-Qt6/releases) for compiled binary executable files.

### Windows

All required Qt libraries have been packed into one .exe file. So it should work out of the box.

### Linux

The Qt libraries (version >= 5.2.1) are required. Make sure that they are installed on your system.

### Arch Linux

Install the AUR package [2048-qt](https://aur.archlinux.org/packages/2048-qt/) through:
```
yaourt 2048-qt
```
And please vote it if you like it.

### Debian

[Alejandro Garrido Mota](https://github.com/mogaal) has packaged it for Debian. On Debian unstable, install it through:
```
sudo apt-get install 2048-qt
```

### Gentoo
2048-Qt is available from the overlay maintained by [Jorge Pizarro Callejas](https://github.com/jorgicio):
```
layman -a jorgicio
emerge 2048-qt
```

### Ubuntu

From Ubuntu 14.10 on, install it through:
```
sudo apt-get install 2048-qt
```

## Todo

- Allow the user to add his own label systems
- AI support
