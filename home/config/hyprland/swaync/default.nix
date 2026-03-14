{ ... }:
{
  services.swaync = {
    # notify-send "test" "swaync works"
    enable = true;
    # Ref: https://github.com/ErikReider/SwayNotificationCenter/blob/main/src/configSchema.json
    settings = {
    };
    style = ''

    '';
  };
}
