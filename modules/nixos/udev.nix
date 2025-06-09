{
  services.udev.extraRules = ''
    SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{serial}=="B0049N80", SYMLINK+="rs1"
    SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{serial}=="B0049W4Q", SYMLINK+="rs2"
  '';
}
