with import <nixpkgs> {};

buildGoPackage rec {
  name = "elvish-${version}";
  version = "bac2d37";

  goPackagePath = "github.com/elves/elvish";

  src = fetchFromGitHub {
    repo = "elvish";
    owner = "elves";
    rev = version;
    sha256 = "0ilnl439pfmkhn068n7cg0vmyqfbsq0r10ylhcgh4xhkq954gv2l";
  };

  passthru = {
    shellPath = "/bin/elvish";
  };

  meta = with stdenv.lib; {
    description = "A friendly and expressive Unix shell";
    homepage = https://github.com/elves/elvish;
    license = licenses.bsd2;
    maintainers = with maintainers; [ vrthra ];
    platforms = with platforms; linux ++ darwin;
  };
}
