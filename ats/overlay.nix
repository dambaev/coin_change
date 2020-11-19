self: super: {
  coin_change = self.callPackage ./derivation.nix {};
}
