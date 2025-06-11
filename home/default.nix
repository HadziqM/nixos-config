{
  home-manager,
  pkgs,
  extraSpecialArgs,
  ...
}:
let
  configuration = home-manager.lib.homeManagerConfiguration;
in
{

  # "developer" = configuration {
  #   inherit pkgs extraSpecialArgs;
  #   modules = [ ./hadziq/ ];
  # };

  "minimal" = configuration {
    inherit pkgs extraSpecialArgs;
    modules = [ ./minimal/home.nix ];
  };
  "full" = configuration {
    inherit pkgs extraSpecialArgs;
    modules = [ ./hadziq/home.nix ];
  };
}
