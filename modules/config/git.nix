{
  pkgs,
  githubUsername,
  githubEmail,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # GitHub CLI - used for auth, PR/issue management, and HTTPS credential delegation
    gh
    # Terminal UI for Git - visual branch/diff/commit management
    lazygit
    # Repository manager - clone and organize repos under ~/src/<host>/<owner>/<repo>
    # Ref: https://zenn.dev/oreo2990/articles/13c80cf34a95af
    ghq
    # Interactive line-filtering tool - used with ghq for fuzzy repo switching (Ctrl+g in zsh)
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
      # Delegate GitHub HTTPS credential handling to the gh CLI (runs `gh auth git-credential`)
      #credential = {
      #   "https://github.com".helper = "!gh auth git-credential";
      #};
      # All repositories cloned via ghq are stored under ~/src
      ghq = {
        root = "~/src";
      };
    };
  };
}
