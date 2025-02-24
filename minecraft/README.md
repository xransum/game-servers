# Minecraft Server Setup

Just a WIP repo in helping with automating minecraft hosting and server creation.

> Take note, this is not entirely to be used by other people, you are responsible for whatever happens to your server using this repositories contents.

## Overview

- *IMPORTANT*: This has only been tested using - [Debian 10 "Buster" Release](https://www.debian.org/News/2019/20190706).
- [minecraft@.service](./systemd/system/minecraft@.service) - The systemd unit file for being able to easily run headless services.
- [setup.sh](./scripts/setup.sh) - Setup script that provides the commands necessary for the initial setup of the environment.
- [update-owner.sh](./scripts/update_owner.sh) - Script for updating all file ownership to the valid runas instead of root or the user themselves.

## Setup

- **To be determined.**
- All server files will be located within the system account `minecraft`, so for example: `stoneblock-3` server files should be located `/home/minecraft/stoneblock-3/`.

## Starting

- Enable a unit service to be able to run on restart.

```bash
sudo systemctl enable minecraft@stoneblock-3
```

- To start the server.

```bash
sudo systemctl start minecraft@stoneblock-3
```

- To soft-restart the server.

```bash
sudo systemctl restart minecraft@stoneblock-3
```

- Remove service.

```bash
sudo systemctl disable minecraft@stoneblock-3
```

## Java Versions Per Server Version

For any of the versions below, scroll to the latest version for the major version you require and copy the URL to the `Linux x64 Debian Package` and follow the steps under [Installing a Java Version](#installing-a-java-version):

- [Java 8](https://www.oracle.com/in/java/technologies/javase/javase8u211-later-archive-downloads.html):
  - Forge / Fabric <=1.16
- [Java 11](https://www.oracle.com/in/java/technologies/javase/jdk11-archive-downloads.html):
  - Vanilla `1.16 and below`
  - Paper / spigot `1.16 and below`
  - Bungeecord / Waterfall: `any`
- [Java 16](https://www.oracle.com/java/technologies/javase/jdk16-archive-downloads.html):
  - Vanilla `1.17 and above`
  - Paper / spigot `1.17 and above`
  - Forge / Fabric `1.17 and above`
- [Java 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html):
  - Vanilla `1.18 and above`
  - Paper / Spigot `1.18 and above`
  - Forge / Fabric `1.18 and above`
- [Java 21](https://www.oracle.com/java/technologies/javase/jdk21-archive-downloads.html):
  - Vanilla `1.20.5 and above`
  - Paper / Spigot `1.20.5 and above`
  - Forge / Fabric `1.20.5 and above`

## Installing a Java Version

1. **Download the Debian package for the desired Java version**
   Replace the URL with the version you need. For example, to install Java 21:

   ```bash
   wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
   ```

2. **Install the package using `dpkg`**
   This will install the downloaded Java Development Kit (JDK):

   ```bash
   sudo dpkg -i jdk-21_linux-x64_bin.deb
   ```

3. **Verify the installation**
   Check the installed Java version to confirm:

   ```bash
   java -version
   ```

4. **Set the default Java version**
   If multiple Java versions are installed, use `update-alternatives` to configure the default:

   ```bash
   sudo update-alternatives --config java
   ```

   Follow the on-screen prompts to select the desired version.
