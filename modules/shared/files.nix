{ pkgs, config, ... }:

let
  githubPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINXXcsy033rdcu7O7XYBDBZ8R1BmO40Yc3eq2csi5bDe tharaka.uo@gmail.com";
  githubPublicSigningKey = ''
  -----BEGIN PGP PUBLIC KEY BLOCK-----

  mDMEZ3afPBYJKwYBBAHaRw8BAQdA9VQL2SPT+eDxJ5RqAR+qFZc1GKyLyO/UkUHi
  9Ki+cQu0J1RoYXJha2EgRGUgU2lsdmEgPHRoYXJha2EudW9AZ21haWwuY29tPoiT
  BBMWCgA7FiEERYTLuKaiP45rQ07egyfsJEEEL/gFAmd2nzwCGwMFCwkIBwICIgIG
  FQoJCAsCBBYCAwECHgcCF4AACgkQgyfsJEEEL/j/gQEA6GFVIfsbyY8a+TE0a2Xy
  BRIm33irMWENmAOYILYGFlwBAKjRYQOGXqrqsJtpVfIdHktcAHTwDseIsTpfusnp
  TzkCuDgEZ3afPBIKKwYBBAGXVQEFAQEHQPwCEOMKRLW3O35lCigkJ5JYTPQNORGI
  s7SMSEX9utxSAwEIB4h4BBgWCgAgFiEERYTLuKaiP45rQ07egyfsJEEEL/gFAmd2
  nzwCGwwACgkQgyfsJEEEL/gfUAD/cdwHz8xhFA4Nf0TYb7gER0sSN6wiC6OSn99S
  mjJPtA0BAJe5lqD8vSde8SUjPpR0BPzSNub9kXAz6UB+jwlKJpoI
  =37i4
  -----END PGP PUBLIC KEY BLOCK-----
  '';

  cursorSettings = ''
  {
    "cSpell.userWords": [
        "bgcolor",
        "clsx",
        "dtype",
        "MACD", 
        "notistack",
        "Stoch",
        "taapi",
        "tharakadesilva"
    ],
    "cursor.composer.collapsePaneInputBoxPills": true,
    "cursor.composer.renderPillsInsteadOfBlocks": true,
    "cursor.cpp.enablePartialAccepts": true,
    "diffEditor.ignoreTrimWhitespace": false,
    "editor.fontFamily": "'JetbrainsMono Nerd Font'",
    "editor.inlineSuggest.enabled": true,
    "editor.suggestSelection": "first",
    "explorer.confirmDelete": false,
    "files.autoSave": "afterDelay",
    "json.schemas": [],
    "terminal.integrated.fontFamily": "JetbrainsMono Nerd Font",
    "typescript.updateImportsOnFileMove.enabled": "always",
    "workbench.colorTheme": "GitHub Dark Default",
    "workbench.iconTheme": "material-icon-theme",
    "yaml.customTags": [
        "!And",
        "!And sequence",
        "!Base64",
        "!Cidr",
        "!Equals",
        "!Equals sequence",
        "!FindInMap",
        "!FindInMap sequence",
        "!GetAtt",
        "!GetAZs",
        "!If",
        "!If sequence",
        "!ImportValue",
        "!ImportValue sequence",
        "!Join",
        "!Join sequence",
        "!Not",
        "!Not sequence",
        "!Or",
        "!Or sequence",
        "!Ref",
        "!Select",
        "!Select sequence",
        "!Split",
        "!Split sequence",
        "!Sub",
        "!Sub sequence"
    ],
    "yaml.schemas": {}
  }
  '';

in
{

  ".ssh/id_github.pub" = {
    text = githubPublicKey;
  };

  ".ssh/gpg_github.pub" = {
    text = githubPublicSigningKey;
  };

  "Library/Application Support/Cursor/User/settings.json" = {
    text = cursorSettings;
  };
}
