{ pkgs, username, ... }:
{
  home = {
    file = {
      "dictionary_list" = {
        enable = true;
        source = ./dictionary_list;
        target = "/home/${username}/.local/share/fcitx5/skk/dictionary_list";
      };
    };
  };
}
