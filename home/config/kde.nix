{inputs, ...}: {
  inputs.programs = {
    commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Alt+K";
      command = "konsole";
    };
  };
}
