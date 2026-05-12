{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  firefox-addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
  cfg = config.application.zen;
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  config = lib.mkIf cfg {
    programs = {
      zen-browser = {
        enable = cfg;
        setAsDefaultBrowser = true;
        policies = {
          AutofillAddressEnabled = true;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = false;
          OfferToSaveLogins = false;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
          ExtensionSettings = {
            "*" = {
              blocked_install_message = "";
              install_sources = [ "https://addons.mozilla.org/*" ];
              installation_mode = "allowed";
            };
            "addon@bitwarden.com" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
              default_area = "navbar";
              private_browsing = false;
            };
            "cookie-editor@cgagnier.ca" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/cookie-editor/latest.xpi";
              default_area = "menupanel";
              private_browsing = false;
            };
            "addon@darkreader.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
              default_area = "menupanel";
              private_browsing = false;
            };
            "foxyproxy@eric.h.jung" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/foxyproxy-standard/latest.xpi";
              default_area = "menupanel";
              private_browsing = false;
            };
            "hacktools@sekuritylab.com" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/hacktools/latest.xpi";
              default_area = "menupanel";
              private_browsing = false;
            };
            "{owasp-ptk@owasp.org}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/owasp-penetration-testing-kit/latest.xpi";
              default_area = "menupanel";
              private_browsing = false;
            };
            "jid1-MnnxcxisBPnSXQ@jetpack" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
              default_area = "menupanel";
              private_browsing = false;
            };
            "extension@return-youtube-dislikes.com" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
              default_area = "menupanel";
              private_browsing = false;
            };
            "sponsorBlocker@ajay.app" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
              default_area = "menupanel";
              private_browsing = false;
            };
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              default_area = "navbar";
              private_browsing = true;
            };
            "vimium-c@gdh1995.cn" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
              default_area = "menupanel";
              private_browsing = true;
            };
            "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
              default_area = "menupanel";
              private_browsing = false;
            };
            "wappalyzer@crunchlabz.com" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/wappalyzer/latest.xpi";
              default_area = "menupanel";
              private_browsing = false;
            };
            "wayback_machine@mozilla.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/wayback-machine/latest.xpi";
              default_area = "menupanel";
              private_browsing = false;
            };
          };
        };
        nativeMessagingHosts = [
          pkgs.bitwarden-desktop
        ];
        profiles."default" = {
          pinsForce = true;
          pinsForceAction = "remove";
          pins = {
            "Mammouth" = {
              id = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
              url = "https://mammouth.ai";
              position = 101;
              isEssential = true;
            };
            "YouTube" = {
              id = "b2c3d4e5-f6a7-8901-bcde-f12345678901";
              url = "https://www.youtube.com";
              position = 104;
              isEssential = true;
            };
            "Enium Auth" = {
              id = "d4e5f6a7-b8c9-0123-defa-234567890123";
              url = "https://auth.enium.eu";
              position = 102;
              isEssential = true;
            };
            "Github" = {
              id = "d4e5f6a7-b8c9-0123-defa-234567890122";
              url = "https://github.com";
              position = 105;
              isEssential = true;
            };
            "42 Intra" = {
              id = "c3d4e5f6-a7b8-9012-cdef-123456789012";
              url = "https://intra.42.fr";
              position = 103;
              isEssential = true;
            };
            "Friends42" = {
              id = "c3d4e5f6-a7b8-9012-cdef-123456789011";
              url = "https://friends.42paris.fr";
              position = 106;
              isEssential = true;
            };
          };
          bookmarks = {
            force = true;
            settings = [
              {
                name = "Documentation";
                bookmarks = [
                  {
                    name = "DevDocs Offline";
                    url = "https://devdocs.io/offline";
                  }
                  {
                    name = "C++ Tutorial";
                    url = "https://cplusplus.com/doc/oldtutorial/";
                  }
                  {
                    name = "cppreference";
                    url = "https://en.cppreference.com/w/";
                  }
                  {
                    name = "Rust Book";
                    url = "https://doc.rust-lang.org/stable/book/";
                  }
                  {
                    name = "GNU libc";
                    url = "https://www.gnu.org/software/libc/manual/html_node/POSIX.html";
                  }
                  {
                    name = "POSIX Utilities";
                    url = "https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html";
                  }
                  {
                    name = "Linux Kernel";
                    url = "https://www.kernel.org/doc/html/latest/";
                  }
                  {
                    name = "Bash Manual";
                    url = "https://www.gnu.org/software/bash/manual/bash.html";
                  }
                  {
                    name = "42 API Doc";
                    url = "https://api.intra.42.fr/apidoc";
                  }
                  {
                    name = "Pulgamecanica";
                    url = "https://pulgamecanica.herokuapp.com/";
                  }
                  {
                    name = "Bit Hacks";
                    url = "https://graphics.stanford.edu/~seander/bithacks.html";
                  }
                  {
                    name = "IRC Docs";
                    url = "https://modern.ircdocs.horse/";
                  }
                  {
                    name = "Deckly";
                    url = "https://deckly.dev/";
                  }
                  {
                    name = "MyNixOS";
                    url = "https://mynixos.com/";
                  }
                  {
                    name = "StackOverflow";
                    url = "https://stackoverflow.com/";
                  }
                  {
                    name = "Mailjet";
                    url = "https://app.mailjet.com/account/sender/authenticate-domain?dns=4759252364";
                  }
                  {
                    name = "Godbolt";
                    url = "https://godbolt.org/";
                  }
                  {
                    name = "Hosted Software";
                    url = "https://hostedsoftware.org/";
                  }
                ];
              }
              {
                name = "42";
                bookmarks = [
                  {
                    name = "Intra";
                    url = "https://profile.intra.42.fr/";
                  }
                  {
                    name = "Tutors";
                    url = "https://tutors.42paris.fr/";
                  }
                  {
                    name = "GCC";
                    url = "https://gcc.42.fr/";
                  }
                  {
                    name = "Friends";
                    url = "https://friends.42paris.fr/";
                  }
                  {
                    name = "Mastering 42";
                    url = "https://haglobah.github.io/Mastering-42/";
                  }
                  {
                    name = "iintra.xpi";
                    url = "https://maix.me/iintra.xpi";
                  }
                  {
                    name = "Exercism";
                    url = "https://exercism.org/dashboard";
                  }
                ];
              }
              {
                name = "Shopping";
                bookmarks = [
                  {
                    name = "Amazon";
                    url = "https://www.amazon.fr/";
                  }
                  {
                    name = "Fangamer";
                    url = "https://www.fangamer.com/";
                  }
                  {
                    name = "Japan-Sama";
                    url = "https://www.japan-sama.fr/";
                  }
                  {
                    name = "Peak Design";
                    url = "https://www.peakdesign.com/eu/";
                  }
                  {
                    name = "Monkeytype";
                    url = "https://monkeytype.com/";
                  }
                ];
              }
              {
                name = "3D Printer";
                bookmarks = [
                  {
                    name = "Sunlu";
                    url = "https://sunlu.fr/";
                  }
                  {
                    name = "Printables";
                    url = "https://www.printables.com/?lang=fr";
                  }
                ];
              }
              {
                name = "Reseaux";
                bookmarks = [
                  {
                    name = "Twitch";
                    url = "https://www.twitch.tv/";
                  }
                  {
                    name = "Instagram";
                    url = "https://www.instagram.com/";
                  }
                  {
                    name = "Reddit";
                    url = "https://www.reddit.com/";
                  }
                  {
                    name = "Twitter";
                    url = "https://twitter.com/home";
                  }
                ];
              }
              {
                name = "Streaming";
                bookmarks = [
                  {
                    name = "Disney+";
                    url = "https://www.disneyplus.com/home";
                  }
                  {
                    name = "Netflix";
                    url = "https://www.netflix.com/fr";
                  }
                  {
                    name = "Franime";
                    url = "https://franime.fr/";
                  }
                  {
                    name = "Anime-Sama";
                    url = "https://anime-sama.to/";
                  }
                  {
                    name = "YouTube";
                    url = "https://www.youtube.com/";
                  }
                ];
              }
              {
                name = "Hack's Resources";
                bookmarks = [
                  {
                    name = "Vuln DB";
                    bookmarks = [
                      {
                        name = "Exploit-DB";
                        url = "https://www.exploit-db.com/";
                      }
                      {
                        name = "OpenCVE";
                        url = "https://app.opencve.io/cve/";
                      }
                      {
                        name = "WPScan";
                        url = "https://wpscan.com/wordpresses";
                      }
                      {
                        name = "Patchstack";
                        url = "https://patchstack.com/database/";
                      }
                      {
                        name = "NVD NIST";
                        url = "https://nvd.nist.gov/";
                      }
                      {
                        name = "CVE Details";
                        url = "https://www.cvedetails.com/";
                      }
                      {
                        name = "PacketStorm";
                        url = "https://packetstormsecurity.com/";
                      }
                      {
                        name = "VulDB";
                        url = "https://vuldb.com/";
                      }
                      {
                        name = "CXSecurity";
                        url = "https://cxsecurity.com/exploit/";
                      }
                      {
                        name = "Vulnerability Lab";
                        url = "https://www.vulnerability-lab.com/";
                      }
                      {
                        name = "Rapid7";
                        url = "https://www.rapid7.com/db/";
                      }
                    ];
                  }
                  {
                    name = "Awesome";
                    bookmarks = [
                      {
                        name = "AttackerKB";
                        url = "https://attackerkb.com/";
                      }
                      {
                        name = "ChatGPT";
                        url = "https://chat.openai.com/";
                      }
                      {
                        name = "Cyberspace Gitbook";
                        url = "https://martian1337.gitbook.io/cyberspace/";
                      }
                    ];
                  }
                  {
                    name = "Crypto Tools";
                    bookmarks = [
                      {
                        name = "OOK!";
                        url = "https://www.splitbrain.org/_static/ook/";
                      }
                      {
                        name = "Cipher Identifier";
                        url = "https://www.boxentriq.com/code-breaking/cipher-identifier";
                      }
                      {
                        name = "CrackStation";
                        url = "https://crackstation.net/";
                      }
                      {
                        name = "CrackStation Wordlist";
                        url = "https://crackstation.net/crackstation-wordlist-password-cracking-dictionary.htm";
                      }
                      {
                        name = "CyberChef";
                        url = "https://gchq.github.io/CyberChef/";
                      }
                      {
                        name = "All Hashes";
                        url = "https://www.browserling.com/tools/all-hashes";
                      }
                      {
                        name = "Online Tools";
                        url = "https://emn178.github.io/online-tools/";
                      }
                      {
                        name = "MD5 Hashing";
                        url = "https://md5hashing.net/hash";
                      }
                      {
                        name = "Hash Type Checker";
                        url = "https://md5hashing.net/hash_type_checker";
                      }
                      {
                        name = "Hashes.com";
                        url = "https://hashes.com/en/decrypt/hash";
                      }
                      {
                        name = "HashKiller";
                        url = "https://hashkiller.io/";
                      }
                      {
                        name = "ROT13";
                        url = "https://rot13.com/";
                      }
                      {
                        name = "Dencoder";
                        url = "https://meyerweb.com/eric/tools/dencoder/";
                      }
                      {
                        name = "Vigenere Cipher";
                        url = "https://cryptii.com/pipes/vigenere-cipher";
                      }
                      {
                        name = "XOR";
                        url = "https://xor.pw/";
                      }
                    ];
                  }
                  {
                    name = "Hacking Platforms";
                    bookmarks = [
                      {
                        name = "HackTheBox";
                        url = "https://www.hackthebox.eu/";
                      }
                      {
                        name = "PentesterLab";
                        url = "https://pentesterlab.com/";
                      }
                      {
                        name = "PortSwigger";
                        url = "https://portswigger.net/web-security/all-labs";
                      }
                      {
                        name = "Offensive Security";
                        url = "https://www.offensive-security.com/labs/";
                      }
                      {
                        name = "PwnX";
                        url = "https://pwnx.io/";
                      }
                      {
                        name = "Root-Me";
                        url = "https://www.root-me.org/?lang=en";
                      }
                      {
                        name = "TryHackMe";
                        url = "https://tryhackme.com/";
                      }
                    ];
                  }
                  {
                    name = "Hardware";
                    bookmarks = [
                      {
                        name = "Rabbit Labs";
                        url = "https://rabbit-labs.com/";
                      }
                      {
                        name = "Flipper Zero";
                        url = "https://flipperzero.one/";
                      }
                      {
                        name = "M5Stack";
                        url = "https://shop.m5stack.com/";
                      }
                      {
                        name = "Hak5";
                        url = "https://hak5.org/";
                      }
                      {
                        name = "Maltronics";
                        url = "https://maltronics.com/";
                      }
                    ];
                  }
                  {
                    name = "JavaScript";
                    bookmarks = [
                      {
                        name = "JSNice";
                        url = "http://www.jsnice.org/";
                      }
                      {
                        name = "Beautifier";
                        url = "https://beautifier.io/";
                      }
                      {
                        name = "Prettier";
                        url = "https://prettier.io/playground/";
                      }
                      {
                        name = "AAEncode";
                        url = "https://utf-8.jp/public/aaencode.html";
                      }
                      {
                        name = "JS Obfuscator";
                        url = "https://beautifytools.com/javascript-obfuscator.php";
                      }
                      {
                        name = "Obfuscator.io";
                        url = "https://obfuscator.io/";
                      }
                      {
                        name = "JJEncode";
                        url = "https://utf-8.jp/public/jjencode.html";
                      }
                      {
                        name = "JSFuck";
                        url = "http://www.jsfuck.com/";
                      }
                      {
                        name = "JS Minifier";
                        url = "https://javascript-minifier.com/";
                      }
                      {
                        name = "JSConsole";
                        url = "https://jsconsole.com/";
                      }
                      {
                        name = "JSFiddle";
                        url = "https://jsfiddle.net/";
                      }
                    ];
                  }
                  {
                    name = "OSINT";
                    bookmarks = [
                      {
                        name = "OSINT Tracker";
                        url = "https://www.osintracker.com/training-kit";
                      }
                      {
                        name = "Onion Network";
                        url = "http://kn3hl4xwon63tc6hpjrwza2npb7d4w5yhbzq7jjewpfzyhsd65tm6dad.onion/";
                      }
                      {
                        name = "Ransomware";
                        url = "http://ransomwr3tsydeii4q43vazm7wofla5ujdajquitomtd47cxjtfgwyyd.onion/";
                      }
                      {
                        name = "Torch";
                        url = "http://torchdeedp3i2jigzjdmfpn5ttjhthh5wbmda2rr3jvqjg5p77c54dqd.onion/";
                      }
                      {
                        name = "Any.run";
                        url = "https://app.any.run/";
                      }
                      {
                        name = "Hybrid Analysis";
                        url = "https://hybrid-analysis.com/";
                      }
                      {
                        name = "CentralOps";
                        url = "https://centralops.net/co/";
                      }
                      {
                        name = "Whois";
                        url = "https://www.whois.com/";
                      }
                      {
                        name = "Abuse.ch";
                        url = "https://abuse.ch/";
                      }
                      {
                        name = "ASINT Collection";
                        url = "https://start.me/p/b5Aow7/asint_collection";
                      }
                      {
                        name = "Censys Certs";
                        url = "https://search.censys.io/certificates";
                      }
                      {
                        name = "Censys IPv4";
                        url = "https://censys.io/ipv4";
                      }
                      {
                        name = "Talos Intelligence";
                        url = "https://talosintelligence.com/";
                      }
                      {
                        name = "Malware Research";
                        url = "https://malware-research.org/coinblockerlists/";
                      }
                      {
                        name = "CommanderGirl";
                        url = "https://start.me/p/1kJKR9/commandergirl-s-suggestions?locale=en";
                      }
                      {
                        name = "crt.sh";
                        url = "https://crt.sh/";
                      }
                      {
                        name = "DarkFeed";
                        url = "https://darkfeed.io/";
                      }
                      {
                        name = "DeDigger";
                        url = "https://www.dedigger.com/#gsc.tab=0";
                      }
                      {
                        name = "DeHashed";
                        url = "https://dehashed.com/";
                      }
                      {
                        name = "DiffChecker";
                        url = "https://www.diffchecker.com/image-compare/";
                      }
                      {
                        name = "Photo Forensics";
                        url = "https://29a.ch/photo-forensics/#forensic-magnifier";
                      }
                      {
                        name = "GreyNoise";
                        url = "https://www.greynoise.io/viz/";
                      }
                      {
                        name = "HaveIBeenEmotet";
                        url = "https://www.haveibeenemotet.com/";
                      }
                      {
                        name = "HaveIBeenPwned";
                        url = "https://haveibeenpwned.com/";
                      }
                      {
                        name = "Hunter.io";
                        url = "https://hunter.io/";
                      }
                      {
                        name = "i2OCR";
                        url = "https://www.i2ocr.com/";
                      }
                      {
                        name = "ICANN Lookup";
                        url = "https://lookup.icann.org/en";
                      }
                      {
                        name = "Insecam";
                        url = "http://insecam.org/";
                      }
                      {
                        name = "IntelX";
                        url = "https://intelx.io/";
                      }
                      {
                        name = "Maltiverse";
                        url = "https://maltiverse.com/search";
                      }
                      {
                        name = "MXToolbox";
                        url = "https://mxtoolbox.com/";
                      }
                      {
                        name = "NerdyData";
                        url = "https://www.nerdydata.com/";
                      }
                      {
                        name = "Netograph";
                        url = "https://netograph.io/";
                      }
                      {
                        name = "NS Tools";
                        url = "https://ns.tools/";
                      }
                      {
                        name = "Onyphe";
                        url = "https://www.onyphe.io/";
                      }
                      {
                        name = "OSINT Framework";
                        url = "https://osintframework.com/";
                      }
                      {
                        name = "Pipl";
                        url = "https://pipl.com/";
                      }
                      {
                        name = "Pulsedive";
                        url = "https://pulsedive.com/";
                      }
                      {
                        name = "Rapid7 OpenData";
                        url = "https://opendata.rapid7.com/";
                      }
                      {
                        name = "Scamalytics";
                        url = "https://scamalytics.com/";
                      }
                      {
                        name = "Shodan";
                        url = "https://shodan.io/";
                      }
                      {
                        name = "Squatm3gator";
                        url = "https://github.com/david3107/squatm3gator";
                      }
                      {
                        name = "TinEye";
                        url = "https://tineye.com/";
                      }
                      {
                        name = "ViewDNS";
                        url = "https://viewdns.info/";
                      }
                      {
                        name = "Vigilante";
                        url = "https://vigilante.pw/";
                      }
                      {
                        name = "VirusTotal";
                        url = "https://www.virustotal.com/gui/";
                      }
                      {
                        name = "Wappalyzer";
                        url = "https://www.wappalyzer.com/";
                      }
                      {
                        name = "WiGLE";
                        url = "https://www.wigle.net/";
                      }
                      {
                        name = "XResolver";
                        url = "https://xresolver.com/index";
                      }
                      {
                        name = "Yandex Images";
                        url = "https://yandex.com/images/";
                      }
                      {
                        name = "ZoomEye";
                        url = "https://www.zoomeye.org/";
                      }
                      {
                        name = "ZorexEye";
                        url = "http://zorexeye.com/";
                      }
                      {
                        name = "0t.rocks";
                        url = "https://search.0t.rocks/";
                      }
                      {
                        name = "Web Check";
                        url = "https://web-check.as93.net/";
                      }
                    ];
                  }
                  {
                    name = "Reverse Shells";
                    bookmarks = [
                      {
                        name = "PayloadsAllTheThings";
                        url = "https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md";
                      }
                      {
                        name = "PHP Reverse Shell";
                        url = "https://github.com/pentestmonkey/php-reverse-shell/blob/master/php-reverse-shell.php";
                      }
                      {
                        name = "PentestMonkey";
                        url = "https://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet";
                      }
                      {
                        name = "HighOn.Coffee";
                        url = "https://highon.coffee/blog/reverse-shell-cheat-sheet/";
                      }
                      {
                        name = "RevShells";
                        url = "https://www.revshells.com/";
                      }
                    ];
                  }
                  {
                    name = "Web Shells";
                    bookmarks = [
                      {
                        name = "Web Shell 1";
                        url = "https://gist.github.com/mrpapercut/9e4f511e74fdf3796d0abcc4de182b65";
                      }
                      {
                        name = "Web Shell 2";
                        url = "https://gist.github.com/sente/4dbb2b7bdda2647ba80b";
                      }
                    ];
                  }
                ];
              }
            ];
          };
          search = {
            force = true;
            default = "ddg";
            privateDefault = "ddg";
          };
          extensions = {
            force = true;
            packages = with firefox-addons; [
              bitwarden
              cookie-editor
              darkreader
              foxyproxy-standard
              hacktools
              owasp-penetration-testing-kit
              privacy-badger
              return-youtube-dislikes
              sponsorblock
              ublock-origin
              vimium-c
              violentmonkey
              wappalyzer
              wayback-machine
            ];
          };
          settings = {
            # UI
            "ui.textScaleFactor" = 120;
            "browser.uidensity" = 1;
            "browser.theme.content-theme" = 0;
            "browser.theme.toolbar-theme" = 0;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

            # Zen
            "zen.view.compact.enable-at-startup" = true;
            "zen.theme.accent-color" = "#8caaee";
            "zen.tabs.vertical.right-side" = false;
            "zen.view.use-single-toolbar" = false;
            "zen.welcome-screen.seen" = true;

            # Privacy
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
            "privacy.fingerprintingProtection" = true;
            "privacy.sanitize.sanitizeOnShutdown" = false;
            "privacy.clearOnShutdown.history" = false;
            "privacy.clearOnShutdown.cookies" = false;
            "privacy.clearOnShutdown.cache" = true;
            "privacy.clearOnShutdown.downloads" = false;

            # Telemetry
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "browser.ping-centre.telemetry" = false;
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;

            # Network
            "network.dns.disablePrefetch" = true;
            "network.prefetch-next" = false;
            "network.http.speculative-parallel-limit" = 0;

            # Passwords
            "signon.rememberSignons" = false;
            "signon.autofillForms" = false;

            # Performance
            "gfx.webrender.all" = true;
            "media.ffmpeg.vaapi.enabled" = true;
            "media.hardware-decoding.force-enabled" = true;

            # Misc
            "browser.shell.checkDefaultBrowser" = false;
            "browser.startup.page" = 3;
            "browser.sessionstore.resume_from_crash" = true;
            "browser.newtabpage.enabled" = false;
            "browser.download.useDownloadDir" = true;
          };
        };
      };
    };
  };
}
