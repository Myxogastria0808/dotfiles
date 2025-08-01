{
  pkgs,
  githubUsername,
  githubEmail,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    gh
    lazygit
    # Reference: https://zenn.dev/oreo2990/articles/13c80cf34a95af
    ghq
    # Simplistic interactive filtering tool
    peco
  ];
  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "${githubUsername}";
        email = "${githubEmail}";
      };
      credential = {
        "https://github.com".helper = "!gh auth git-credential";
      };
      ghq = {
        root = "~/src";
      };
    };
  };
}
