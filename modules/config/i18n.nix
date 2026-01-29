{ pkgs, ... }:
{
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable fcitx5
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-skk
      ];
    };
  };

  # Set skk dictonaries
  # Reference: https://skk-dev.github.io/dict/
  environment.systemPackages = with pkgs.skkDictionaries; [
    #* Standard dictionary *#
    # SKK-JISYO.L.gz (Largest standard dictionary)
    l
    #* Specialized dictionary *#
    # SKK-JISYO.jinmei.gz (Japanese individuals)
    jinmei
    # SKK-JISYO.fullname.gz (Full names of Japanese individuals published in newspapers)
    fullname
    # SKK-JISYO.geo.gz (Locations in Japan)
    geo
    # SKK-JISYO.propernoun.gz (Proper nouns excluding locations and Japanese individuals)
    propernoun
    # SKK-JISYO.station.gz (Railway terminology)
    station
    # SKK-JISYO.law.gz (Legal terminology)
    law
    # SKK-JISYO.okinawa.gz (Okinawan terminology)
    okinawa
    # SKK-JISYO.china_taiwan.gz (Chinese and Taiwanese locations)
    china_taiwan
    # zipcode.tar.gz (Postal codes terminology)
    zipcode
    # SKK-JISYO.JIS2.gz (JIS X 0208 characters)
    jis2
    # SKK-JISYO.JIS3_4.gz (JIS X 0213 characters)
    jis3_4
    # SKK-JISYO.JIS2004.gz (JIS X 0213:2004 characters)
    jis2004
    # SKK-JISYO.itaiji.gz (Character variant conversion dictionary)
    itaiji
    # SKK-JISYO.itaiji.JIS3_4.gz  (Character variant conversion dictionary for JIS X 0213)
    itaiji_jis3_4
    # SKK-JISYO.mazegaki.gz (Mixed writing dictionary)
    mazegaki
  ];
}
