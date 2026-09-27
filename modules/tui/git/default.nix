{ pkgs, conf, ... }:

{
  packages = [ pkgs.git ];

  xdg.config.files."git/config".text = ''
    [user]
      name = ${conf.github.username}
      email = ${conf.github.email}

    [init]
      defaultBranch = main

    [alias]
      ci = commit
      co = checkout
      s = status
  '';
}
