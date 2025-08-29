{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      e = "exit";
      c = "clear";
      h = "history";

      cat = "bat --style=auto";
      grep = "rg";

      # zoxide
      cd = "z";

      # File operations
      ll = "eza -la";
      la = "eza -la";
      ls = "eza -l";
      lt = "eza --tree";
      tree = "eza -T";

      # Directory navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };
    initContent = ''
      eval "$(atuin init zsh)"
      eval "$(zoxide init zsh)"
      eval "$(starship init zsh)"

      nix-cleanup() {
        sudo rm /nix/var/nix/gcroots/auto/*
        sudo nix-collect-garbage -d
        sudo nix-store --optimise
      }
    '';
  };
}
