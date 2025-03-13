{
  pkgs,
  config,
  ...
}: let
  cursorSettings = ''
    {
      "bazel.buildifierExecutable": "${pkgs.buildifier}/bin/buildifier",
      "bazel.buildifierFixOnFormat": true,
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
      "editor.inlineSuggest.enabled": true,
      "editor.fontFamily": "'JetbrainsMono Nerd Font Mono'",
      "editor.fontSize": 13,
      "editor.formatOnPaste": true,
      "editor.formatOnSave": true,
      "editor.formatOnType": true,
      "editor.suggestSelection": "first",
      "explorer.confirmDelete": false,
      "files.autoSave": "afterDelay",
      "git.confirmSync": false,
      "json.schemas": [],
      "RadonIDE.panelLocation": "side-panel",
      "terminal.integrated.fontFamily": "'JetbrainsMono Nerd Font Mono'",
      "terminal.integrated.fontSize": 13,
      "typescript.updateImportsOnFileMove.enabled": "always",
      "update.releaseTrack": "prerelease",
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
