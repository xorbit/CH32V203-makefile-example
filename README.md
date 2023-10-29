# Basic CH32V203 RISCV Makefile project

Based on [CH32V307-makefile-example](https://github.com/gregdavill/CH32V307-makefile-example)
by Greg Davill, but adjusted for the CH32V203 chip.

Requirements:
 - xpack RISCV toolchain (riscv-none-elf-)

Set up udev rules for WCH link
```
sudo cp ./50-wch.rules   /etc/udev/rules.d  
sudo udevadm control --reload-rules
```

Make project
```
make
```

Flash project with WCH-LinkE debug probe
```
make flash
```

This example also includes WCH OpenOCD binary for Linux and a VSCode setup that allows
for compilation, flash and debug from VSCode.

# Licence

Unless otherwise stated files are licensed as BSD 2-Clause

Files under `vendor/` are from openwch (https://github.com/openwch/ch32v20x) Licensed under Apache-2.0
Makefile is based on an example here: https://github.com/gregdavill/CH32V307-makefile-example
and here: https://github.com/gregdavill/CH32V003-makefile-example
