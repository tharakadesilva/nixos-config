{
  pkgs,
  config,
  ...
}: let
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
in {
  "Library/Application Support/Cursor/User/settings.json" = {
    text = cursorSettings;
  };
}
