{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ starship ];

  programs.starship = {
    enableZshIntegration = true;
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 1000;
      format = ''
         | ($directory) $git_branch$git_status$git_commit : $cmd_duration 
        $character'';
      character = {
        success_symbol = "[󰯙 ](yellow)";
        error_symbol = "[󰯙 ](#ff7700)";
      };
      username = {
        style_user = "red";
        style_root = "dark-red";
        format = "[$username]($style)";
        disabled = false;
        show_always = true;
      };
      hostname = {
        ssh_only = false;
        format = "[$hostname](bold yellow) ";
        disabled = false;
      };
      directory = {
        home_symbol = "󰋞 ~";
        read_only_style = "197";
        read_only = "  ";
        format = "([$path]($style)[$read_only]($read_only_style))";
      };
      git_branch = {
        symbol = " ";
        format = "[$symbol$branch]($style) ";
        style = "bold green";
      };
      git_status = {
        format = "[($all_status$ahead_behind)]($style) ";
        style = "bold green";
        conflicted = "🏳";
        up_to_date = " ";
        untracked = " ";
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
        stashed = " ";
        modified = " ";
        staged = "[++($count)](green)";
        renamed = "襁 ";
        deleted = " ";
      };
    };
  };
}
