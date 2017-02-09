{ stdenv, fetchFromGitHub, pkgconfig, autoreconfHook,
  glibc, zimg, imagemagick, libass, tesseract, yasm,
  python3
}:

stdenv.mkDerivation rec {
  name = "vapoursynth-${version}";
  version = "R36";

  src = fetchFromGitHub {
    owner  = "vapoursynth";
    repo   = "vapoursynth";
    rev    = version;
    sha256 = "10yiccj7yd4bd3a6k15xahb5y3ymcagyaqavh0wal2rwzfck9k8c";
  };

  buildInputs = [
    pkgconfig autoreconfHook
    zimg imagemagick libass glibc tesseract yasm
    (python3.withPackages (ps: with ps; [ sphinx cython ]))
  ];

  configureFlags = [
    "--enable-imwri"
    "--disable-static"
  ];

  meta = with stdenv.lib; {
    description = "A video processing framework with the future in mind";
    homepage    = http://www.vapoursynth.com/;
    license     = licenses.lgpl21;
    platforms   = platforms.unix;
    maintainers = with maintainers; [ rnhmjoj ];
  };

}
