{ pkgs, ... }:
{
  # ── Docker ────────────────────────────────────────────────────────────────────
  # Container runtime (rootful mode; user group access managed in configuration.nix).
  virtualisation.docker.enable = true;

  # Docker CLI tools
  environment.systemPackages = with pkgs; [
    docker-compose # Multi-container orchestration (docker compose up/down)
    lazydocker # Terminal UI for container and image management
  ];
}
