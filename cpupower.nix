{config, ...}: {
  environment.systemPackages =  [config.boot.kernelPackages.cpupower];

}
