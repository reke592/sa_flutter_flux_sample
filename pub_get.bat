@ECHO off
SET proj=%cd%

ECHO **sa_flutter_flux
CD ../sa_flutter_flux
CALL flutter pub get

ECHO **sa_flutter_flux_sample
CD %proj%
CALL flutter pub get
