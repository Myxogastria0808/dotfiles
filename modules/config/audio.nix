{ ... }:
{
  # PipeWire replaces PulseAudio for modern low-latency audio support
  services.pulseaudio.enable = false;
  security.rtkit.enable = true; # Real-time scheduling priority, required by PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # Required for 32-bit applications (e.g., Wine/Steam)
    pulse.enable = true; # PulseAudio-compatible interface for legacy apps
    jack.enable = true; # JACK-compatible interface for professional audio apps
  };
  # Real-time noise suppression for microphone input
  programs.noisetorch.enable = true;
}
