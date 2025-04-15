{
  pkgs,
  inputs,
  lib,
  ...
}:

{

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
        fullScreen
        beautifulLyrics
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        localFiles
      ];
      enabledSnippets = with spicePkgs.snippets; [
        rotatingCoverart
        pointer
      ];

      # theme = lib.mkForce spicePkgs.themes.dreary;
    };
}
