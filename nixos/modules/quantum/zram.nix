{
  config,
  pkgs,
  ...
}: {
  zramSwap = {
    enable = true;
    memoryPercent = 200;
    priority = 999;
  };
}
